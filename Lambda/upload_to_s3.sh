#!/bin/bash
# Set Env variables
source s3_resources_define.sh
# Check for arguments
if [ $# -eq 1 ]
    then
    image_file=$1
fi
# Upload image file to S3 bucket
aws s3 cp $image_file s3://$bucket/