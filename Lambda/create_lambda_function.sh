#!/bin/bash
# Set Env variables
source lambda_resources_define.sh
# Zip lambda function
zip $function.zip $function.py
# Create lambda function
aws lambda create-function \
--region $region \
--function-name $function \
--zip-file fileb://$function.zip \
--handler $function.$handler \
--role $role_arn \
--timeout $timeout \
--runtime $run_env