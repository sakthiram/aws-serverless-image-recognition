import json
import boto3
import os

# BUCKET = "test-walleye"
# KEY = "wallpaper.jpg"

def lambda_handler(event, context):
    # body = {
    #     "message": "Hello from Python 3.6!",
    #     "input": event
    # }

    # rekognition = boto3.client("rekognition", os.environ['AWS_REGION']) # us-west-1 rekognition service is not supported
    BUCKET = event.get('Records')[0].get('s3').get('bucket').get('name')
    KEY = event.get('Records')[0].get('s3').get('object').get('key')
    
    rekognition = boto3.client("rekognition", "us-west-2")
    response = rekognition.detect_labels(
                Image = {
                    "S3Object": {
                        "Bucket" : BUCKET,
                        "Name" : KEY,
                    }
                }
    )

    print (json.dumps(response))

    # response = {
    #     "statusCode": 200,
    #     "body": json.dumps(body)
    # }

    return response