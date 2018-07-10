#!/bin/bash
# Set Env variables
source s3_resources_define.sh
# Upload image file to S3 bucket
aws s3 cp $image_file s3://$bucket/