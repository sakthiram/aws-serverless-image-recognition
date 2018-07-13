#!/bin/bash
# Get Account details
account_id=`aws sts get-caller-identity --query "Account" --output text`
# AWS resources
function="image_analyze_function"
role_arn="arn:aws:iam::$account_id:role/S3_Rek_access"
#AWS env config
run_env="python2.7" # Prebuilt packages for PIL are for Python2.7
region="us-west-2"
handler="lambda_handler"
timeout=30