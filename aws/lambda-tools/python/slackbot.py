import urllib3, json, os, boto3, textwrap, logging


def slackbot(event, context):
    #transform event vars
    account_id = event['account']
    detail_type = event['detail-type']
    event_time = event['time']
    region = event['region']
    status = event['detail']['status']
    window_execution_id = event['detail']['window-execution-id']
    window_id = event['detail']['window-id']

    #init clients
    log_level = os.environ.get('LOG_LEVEL')
    logger = logging.getLogger()
    logger.setLevel(log_level)

    http = urllib3.PoolManager()

    iam_client = boto3.client('iam')
    ssm_client = boto3.client('ssm')
    resource_group_client = boto3.client('resource-groups')

    #alert data harvest
    account_name_query = iam_client.list_account_aliases()
    account_name = account_name_query['AccountAliases'][0]
    ssm_mw_id_query = ssm_client.get_maintenance_window(WindowId=window_id)
    ssm_mw_name = ssm_mw_id_query['Name']
    ssm_mw_task_query = ssm_client.describe_maintenance_window_tasks(WindowId=window_id)
    ssm_mw_target_query = ssm_client.describe_maintenance_window_targets(
        WindowId=window_id
    )
    ssm_mw_target = ssm_mw_target_query['Targets'][0]['Targets'][0]['Values'][0]
    ssm_mw_target_type = ssm_mw_target_query['Targets'][0]['ResourceType']

    if ssm_mw_target_type == 'RESOURCE_GROUP':
        resource_group_query = resource_group_client.list_group_resources(
            Group=ssm_mw_target
        )
        resource_group_members = resource_group_query['Resources']

    #extract instance ids from arns
    if resource_group_members:
        resource_group_member_list = []
        for member in resource_group_members:
            try:
                resource_arn = member['Identifier']['ResourceArn']
                id = resource_arn.split('/')[1]
                resource_group_member_list.append(id)
            except (KeyError, IndexError, TypeError) as e:
                logging.error('Error processing resource group member: %s', member)

    #extract instance names from ids and format
    instance_id_list = []
    for id in resource_group_member_list:
        if id.startswith('mi-'):
            try:
                mi_name_query = ssm_client.describe_instance_information(
                    InstanceInformationFilterList=[
                        {
                            'key': 'InstanceIds',
                            'valueSet': [id],
                        },
                    ]
                )

                if 'InstanceInformationList' in mi_name_query and mi_name_query[
                    'InstanceInformationList']:
                    name = mi_name_query['InstanceInformationList'][0]['ComputerName']
                    instance_id_list.append(name)
            except Exception as e:
                logging.error('Error querying Systems Manager for %s, %s', id, e)

        elif id.startswith('i-'):
            try:
                ec2_client = boto3.client('ec2', region_name=region)
                ec2_name_query = ec2_client.describe_instances(InstanceIds=[id])

                if 'Reservations' in ec2_name_query and ec2_name_query['Reservations']:
                    for name in ec2_name_query['Reservations'][0]['Instances'][0]['Tags']:
                        if name['Key'] == 'Name':
                            name = name['Value']
                            instance_id_list.append(name)
            except Exception as e:
                logging.error('Error querying EC2 for %s, %s', id, e)
    instance_id_string = ' '.join(instance_id_list)

    #event status indicators
    default_color = '#afeded'
    status_fail = '#fc3503'
    status_inprogress = '#afeded'
    status_pass = '#49c91a'
    status_mapping = {
        'SUCCESS': status_pass,
        'PENDING': status_pass,
        'IN_PROGRESS': status_inprogress,
        'CANCELLING': status_inprogress,
        'SKIPPED_OVERLAPPING': status_inprogress,
        'FAILED': status_fail,
        'TIMED_OUT': status_fail,
        'CANCELLED': status_fail,
    }
    color = status_mapping.get(status, default_color)

    #event messaging
    slack_webhook_url = os.environ.get('SLACK_WEBHOOK_URL')
    slack_channel = os.environ.get('SLACK_CHANNEL')
    slack_username = f'Platform SlackBot'
    base_url = f'https://{region}.console.aws.amazon.com/systems-manager/maintenance-windows/{window_id}/history'
    window_execution_url = f'{base_url}/{window_execution_id}?region={region}'
    window_url = f'{base_url}/?region={region}'

    #construct alert payload
    slack_text = textwrap.dedent(
        f'''
    Account/Region: {account_name} {account_id} {region}
    Patch Status: <{window_execution_url}|{status}>
    Patch Window: {ssm_mw_name}
    Patch Group: {ssm_mw_target}
    Patch Targets: {instance_id_string}
    '''
    )

    slack_payload = {
        'channel': slack_channel,
        'username': slack_username,
        'attachments': [{
            'color': color,
            'text': slack_text,
        }]
    }

    #deliver alert payload
    try:
        slack_encoded_payload = json.dumps(slack_payload).encode('utf-8')
        slack_post_payload = http.request(
            'POST', slack_webhook_url, body=slack_encoded_payload
        )

        if 200 <= slack_post_payload.status < 300:
            logging.info(
                'Post successful. status code: %s, message: %s, response: %s',
                slack_post_payload.status, slack_payload, slack_post_payload.data
            )

        else:
            logging.error(
                'Post unsuccessful. status code: %s, message: %s, response: %s',
                slack_post_payload.status, slack_payload, slack_post_payload.data
            )

    except Exception as e:
        logging.error('error deliverying payload occurred. message %s', slack_payload)
