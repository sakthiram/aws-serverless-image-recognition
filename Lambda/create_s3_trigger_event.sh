#!/bin/bash
# Set Env variables
source lambda_resources_define.sh
source s3_resources_define.sh
# Check for arguments
if [ $# -eq 2 ]
    then
    function=$1
    obj_prefix=$2
    s3_trigger_sid="s3_trigger_${function}_sid"
fi

lambda_function_arn=`aws lambda get-function --function-name $function --region $region --query "Configuration.FunctionArn" --output text`
# Add permission for S3 triggering Lambda
aws lambda add-permission \
--function-name $function \
--region $region \
--statement-id $s3_trigger_sid \
--action "lambda:InvokeFunction" \
--principal s3.amazonaws.com \
--source-arn arn:aws:s3:::$bucket \
--source-account $account_id
# Add configurations for S3 trigger event
aws s3api put-bucket-notification-configuration \
--bucket $bucket \
--notification-configuration \
"{\"LambdaFunctionConfigurations\": [
{
    \"LambdaFunctionArn\":\"$lambda_function_arn\",
    \"Events\":[\"s3:ObjectCreated:Put\"],
    \"Filter\":{
        \"Key\":{
            \"FilterRules\":[
                {
                    \"Name\":\"prefix\",
                    \"Value\":\"$obj_prefix\"
                },
                {
                    \"Name\":\"suffix\",
                    \"Value\":\"$obj_suffix\"
                }
            ]
        }
    }
}
]
}"