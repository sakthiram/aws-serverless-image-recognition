#!/bin/bash
# Set Env variables
source lambda_resources_define.sh
path=$function.py
root_path=`pwd`
# Check for arguments
if [ $# -eq 3 ]
    then
    path=$1
    function=$2
    role_arn="arn:aws:iam::$account_id:role/$3"
    pushd $path
elif [ $# -ne 0 ] # Num of args other than 3 or 0
    then exit 1
fi
# Zip lambda function
zip -r $function.zip *
if [ $# -eq 3 ]
    mv $function.zip "$root_path"
    then popd
fi
# Create lambda function
aws lambda create-function \
--region $region \
--function-name $function \
--zip-file fileb://$function.zip \
--handler $function.$handler \
--role $role_arn \
--timeout $timeout \
--runtime $run_env