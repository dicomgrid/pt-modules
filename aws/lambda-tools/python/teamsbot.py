import boto3, json, logging, os, pymsteams

def teamsbot(event, context):
    #transform event vars
    account_id = event['account']
    detail_type = event['detail-type']
    event_time = event['time']
    region = event['region']
    status = event['detail']['status']
    status_details = event.get('detail', {}).get('status-details', None)
    webhook_url = os.environ.get('WEBHOOK_URL')
    window_execution_id = event['detail']['window-execution-id']
    window_id = event['detail']['window-id']

    #init clients
    log_level = os.environ.get('LOG_LEVEL')
    logger = logging.getLogger()
    logger.setLevel(log_level)

    iam_client = boto3.client('iam')
    ssm_client = boto3.client('ssm')
    resource_group_client = boto3.client('resource-groups')
    
    teams_handler = pymsteams.connectorcard(webhook_url)

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
    base_url = f'https://{region}.console.aws.amazon.com/systems-manager/maintenance-windows/{window_id}/history'
    window_execution_url = f'{base_url}/{window_execution_id}?region={region}'
    window_url = f'{base_url}/?region={region}'
    location = f'{account_name}/{region} ({account_id})'

    # #construct alert payload
    teams_handler.color(color)
    teams_handler.title('PLT MW TeamsBot')
    teams_handler.text(location)
    teams_handler.addLinkButton('Execution URL', window_execution_url)
    
    teams_payload = pymsteams.cardsection()
    teams_payload.addFact('Status:', status)
    if status_details:
        teams_payload.addFact('Status Details:', status_details)
    teams_payload.addFact('Window:', ssm_mw_name)
    teams_payload.addFact('Group:', ssm_mw_target)
    teams_payload.addFact('Instances:', instance_id_string)
    teams_handler.addSection(teams_payload)

    #deliver alert payload
    try:
        teams_payload_post = teams_handler.send()
        
        if teams_payload_post:
            logging.info(
                'Post successful. output: %s',
                teams_payload_post
            )
        else:
            logging.error(
                'Post unsuccessful. output: %s',
                teams_payload_post
            )

    except Exception as e:
        logging.error('general exception found. message: %s. exception: %s', 
        teams_payload_post, e)
