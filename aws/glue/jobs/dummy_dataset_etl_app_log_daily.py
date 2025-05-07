import sys
import argparse
import datetime
import logging
import boto3

# Variables (Dummy values for public use)
bucket = "dummy-bucket"
prefix = "dummy-path/app_log/"
s3client = boto3.client('s3')
athena = boto3.client('athena', region_name='dummy-region')

# Functions
def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--year_partition_value", required=True)
    parser.add_argument("--month_partition_value", required=True)
    parser.add_argument("--day_partition_value", required=True)
    args, _ = parser.parse_known_args()
    return args

def checkDate(year, month, day):
    try:
        newDateStr = f"{int(year):04d}-{int(month):02d}-{int(day):02d}"
        datetime.datetime.strptime(newDateStr, "%Y-%m-%d")
        return True
    except ValueError as e:
        print('Invalid Date:', e)
        return False

def delete_all_keys_v2(bucket, prefix, dryrun=False):
    contents_count = 0
    next_token = ''

    while True:
        if next_token == '':
            response = s3client.list_objects_v2(Bucket=bucket, Prefix=prefix)
        else:
            response = s3client.list_objects_v2(Bucket=bucket, Prefix=prefix, ContinuationToken=next_token)

        if 'Contents' in response:
            contents = response['Contents']
            contents_count += len(contents)
            for content in contents:
                path = f"s3://{bucket}/{content['Key']}"
                if not dryrun:
                    print("Deleting:", path)
                    s3client.delete_object(Bucket=bucket, Key=content['Key'])
                else:
                    print("DryRun:", path)

        if 'NextContinuationToken' in response:
            next_token = response['NextContinuationToken']
        else:
            break

    print("Total files:", contents_count)

def main():
    args = get_args()

    if not checkDate(args.year_partition_value, args.month_partition_value, args.day_partition_value):
        print("Invalid parameters.")
        sys.exit(1)

    year = args.year_partition_value
    month = args.month_partition_value
    day = args.day_partition_value
    print(f"year={year} month={month} day={day}")
    target_path = f"{prefix}year={year}/month={month}/day={day}/"

    delete_all_keys_v2(bucket, target_path, False)

    response = athena.start_query_execution(
        QueryString=f"""
            INSERT INTO "dummy_db"."dummy_app_log"
            SELECT
                timestamp, tag, json_extract_scalar(json_extract_scalar(log, '$.message'), '$.AnalyticsEventLogId') AS analytics_event_log_id,
                json_extract_scalar(log, '$.ucompanyId') AS ucompany_id, json_extract_scalar(log, '$.userId') AS user_id,
                json_extract_scalar(log, '$.sessionId') AS session_id,
                json_extract_scalar(json_extract_scalar(log, '$.message'), '$.UserAgent') AS user_agent,
                json_extract_scalar(json_extract_scalar(log, '$.message'), '$.Referrer') AS referrer,
                cast(json_extract_scalar(json_extract_scalar(log, '$.message'), '$.EventId') AS integer) AS event_id,
                json_extract_scalar(json_extract_scalar(log, '$.message'), '$.EventProperty') AS event_properties,
                -- OS extraction
                CASE
                    WHEN json_extract_scalar(json_extract_scalar(log, '$.message'), '$.UserAgent') LIKE '%Macintosh%' THEN 'Mac'
                    WHEN json_extract_scalar(json_extract_scalar(log, '$.message'), '$.UserAgent') LIKE '%iPad%' THEN 'iPad'
                    WHEN json_extract_scalar(json_extract_scalar(log, '$.message'), '$.UserAgent') LIKE '%iPhone%' THEN 'iPhone'
                    ELSE 'Other'
                END AS os,
                -- Browser extraction
                CASE
                    WHEN json_extract_scalar(json_extract_scalar(log, '$.message'), '$.UserAgent') LIKE '%Edge%' THEN 'Edge'
                    WHEN json_extract_scalar(json_extract_scalar(log, '$.message'), '$.UserAgent') LIKE '%Chrome%' THEN 'Chrome'
                    ELSE 'Other'
                END AS browser,
                partition_1 AS year, partition_2 AS month, partition_3 AS day
            FROM "dummy_db"."dummy_logs"
            WHERE partition_0 = 'applog'
              AND partition_1 = '{year}' AND partition_2 = '{month}' AND partition_3 = '{day}'
              AND json_extract_scalar(log, '$.message') LIKE '%AnalyticsEventLogId%'
        """,
        QueryExecutionContext={"Database": "dummy_db"},
        ResultConfiguration={"OutputLocation": "s3://dummy-bucket/dummy-path/glue_logs/"}
    )

    print(f"Query submitted for year={year}, month={month}, day={day}")

if __name__ == '__main__':
    main()
