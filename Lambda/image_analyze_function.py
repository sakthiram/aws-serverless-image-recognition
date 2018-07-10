import json
import boto3
import os

BUCKET = "test-walleye"
KEY = "wallpaper.jpg"

def lambda_handler(event, context):
    # body = {
    #     "message": "Hello from Python 3.6!",
    #     "input": event
    # }

    # rekognition = boto3.client("rekognition", os.environ['AWS_REGION']) # us-west-1 rekognition service is not supported
    rekognition = boto3.client("rekognition", "us-west-2")
    response = rekognition.detect_labels(
                Image = {
                    "S3Object": {
                        "Bucket" : BUCKET,
                        "Name" : KEY,
                    }
                }
    )

    # response = {
    #     "statusCode": 200,
    #     "body": json.dumps(body)
    # }

    return response