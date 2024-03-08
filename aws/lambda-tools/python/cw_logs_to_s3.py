import boto3, json, csv, time, os
# import pandas as pd
from datetime import datetime, timedelta

#TODO: Convert prints to logging paths

logs = boto3.client('logs')
s3 = boto3.resource('s3')
ssm = boto3.client('ssm')


def cw_logs_to_s3(event, context):
    # global default vars
    bucket_name = 'plt-test-cw-log-export'
    export_to_time = int(round(time.time() * 1000))
    extra_args = {}
    log_groups = []
    log_groups_to_export = []
    log_timestamp = '%Y-%m-%d %H:%M:%S'
    ssm_parameter_base = '/cw_logs_to_s3_last_export/'
    ssm_value = 0

    # Gather log groups with ExportToS3 tags set to true
    while True:
        describe_log_groups = logs.describe_log_groups(**extra_args)
        log_groups = log_groups + describe_log_groups['logGroups']

        if not 'nextToken' in describe_log_groups:
            break
        extra_args['nextToken'] = describe_log_groups['nextToken']

    for log_group in log_groups:

        log_group_name = log_group['logGroupName']

        list_tags_log_group = logs.list_tags_log_group(logGroupName=log_group_name)
        log_group_tags = list_tags_log_group['tags']

        if 'ExportToS3' in log_group_tags and log_group_tags['ExportToS3'] == 'true':
            timestamp = datetime.now().strftime(log_timestamp)
            print(
                f'[{timestamp}] Identified log group {log_group_name} with ExportToS3 tag status: {log_group_tags["ExportToS3"]}'
            )
            log_groups_to_export.append(log_group_name)
            timestamp = datetime.now().strftime(log_timestamp)
            print(f'[{timestamp}] --> Log group {log_group_name} added to export list.')

    # Get last export timestamp
    for log_group_name in log_groups_to_export:
        log_group_arn_raw = logs.describe_log_groups(logGroupNamePrefix=log_group_name)
        log_group_arn = log_group_arn_raw['logGroups'][0]['arn']
        account_id = log_group_arn.split(":")[4]
        ssm_parameter_name = ("%s%s" %
                              (ssm_parameter_base, log_group_name)).replace("//", "/")

        '''
        taskId hardcoded in export path, see https://stackoverflow.com/a/71307116
        technique to export to temporary path, then export to finalized formatted path
        Would align with the pd method provided by Azure Sentinel
        '''
        destination_prefix = f"{account_id}{log_group_name}"

        try:
            get_timestamp = ssm.get_parameter(Name=ssm_parameter_name)
            ssm_value = get_timestamp['Parameter']['Value']

            timestamp = datetime.now().strftime(log_timestamp)
            print(
                f'[{timestamp}] Log group {log_group_name} existing timestamp found: {ssm_value}.'
            )
        except ssm.exceptions.ParameterNotFound:
            ssm_value = 0
            timestamp = datetime.now().strftime(log_timestamp)
            print(
                f'[{timestamp}] Log group {log_group_name} timestamp does not exist, using default value.'
            )

        if export_to_time - int(ssm_value) < (24 * 60 * 60 * 1000):
            # Haven't been 24hrs from the last export of this log group
            print(f'[{timestamp}] Skipped until 24hrs from last export is completed')
            continue

    # Execute log export
        create_export_task = logs.create_export_task(
            logGroupName=log_group_name,
            fromTime=ssm_value,
            to=export_to_time,
            destination=bucket_name,
            destinationPrefix=destination_prefix
        )

        export_task_id = create_export_task['taskId']
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f'[{timestamp}] --> Export task {export_task_id} created.')

        # Removing this loop, the export task is a very serial async operation and cannot kick off subsequent jobs until the prior completes
        # Best to reinvoke the lambda for additional log groups than waiting for completetion, max 900 second timeout
        # while True:
        #     timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        #     describe_export_task = logs.describe_export_tasks(taskId=export_task_id)
        #     status = describe_export_task['exportTasks'][0]['status']['code']

        #     if status == 'PENDING':
        #         print(f'[{timestamp}] Export task {export_task_id} for {log_group_name} still waiting to run...')
        #         time.sleep(5)
        #         continue
        #     elif status == 'RUNNING':
        #         print(f'[{timestamp}] Export task {export_task_id} for {log_group_name} running...')
        #         time.sleep(5)
        #         continue
        #     elif status == 'COMPLETED':
        #         print(f'[{timestamp}] --> Export task {export_task_id} completed successfully')
        #         break
        #     elif status == 'FAILED' or status == 'CANCELLED':
        #         print(f'[{timestamp}] Export task {export_task_id} failed or was cancelled.')
        #         break

        # Update export timestamp
        update_timestamp = ssm.put_parameter(
            Name=ssm_parameter_name,
            Type="String",
            Value=str(export_to_time),
            Overwrite=True
        )
        timestamp = datetime.now().strftime(log_timestamp)
        print(
            f'[{timestamp}] --> Log group timestamp updated to {export_to_time}: {update_timestamp["ResponseMetadata"]["HTTPStatusCode"]} {update_timestamp["ResponseMetadata"]["RequestId"]}'
        )


###
### Left for historical knowledge, found from https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/AWS-S3/CloudWatchLambdaFunction.py
###

#         # Convert events to json object
#         json_string = json.dumps(log_events)
#         json_object = json.loads(json_string)

#         df = pd.DataFrame(json_object['events'])

#         # if df.empty:
#         #     print('No events for specified time')

#         # Convert unix time to zulu time for example from 1671086934783 to 2022-12-15T06:48:54.783Z
#         if not df.empty:
#             df['timestamp'] = pd.to_datetime(df['timestamp'], unit='ms')
#             df['timestamp'] = df['timestamp'].dt.strftime('%Y-%m-%dT%H:%M:%S.%f'
#                                                             ).str[:-3] + 'Z'

#                 # Remove unnecessary column
#         fileToS3 = df.drop(columns=["ingestionTime"])

#                 # Export data to temporary file in the right format, which will be deleted as soon as the session ends
#         fileToS3.to_csv(
#             f'/tmp/{OUTPUT_FILE_NAME}.gz',
#             index=False,
#             header=False,
#             compression='gzip',
#             sep=' ',
#             escapechar=' ',
#             doublequote=False,
#             quoting=csv.QUOTE_NONE
#         )

#                 # Upload data to desired folder in bucket
#         s3.Bucket(bucket_name).upload_file(
#             f'/tmp/{OUTPUT_FILE_NAME}.gz', f'{BUCKET_PREFIX}{OUTPUT_FILE_NAME}{current_time_log}.gz'
#         )

#     except Exception as e:
#         print(
#             "    Error exporting %s: %s" %
#             (LOG_GROUP_NAME, getattr(e, 'message', repr(e)))
#         )
