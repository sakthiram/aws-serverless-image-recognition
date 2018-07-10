#!/bin/bash
# AWS resources
function="image_analyze_function"
role_arn="arn:aws:iam::932506246004:role/S3_Rek_access"
#AWS env config
run_env="python3.6"
region="us-west-1"
handler="lambda_handler"
timeout=10