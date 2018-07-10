#!/bin/bash
# Set Env variables
source lambda_resources_define.sh
# Zip lambda function
zip $function.zip $function.py
# Update lambda function
aws lambda update-function-code \
--function-name $function \
--zip-file fileb://$function.zip
# Update lambda function configuration
aws lambda update-function-configuration \
--function-name $function \
--timeout $timeout \
--role $role_arn \
--handler $function.$handler
