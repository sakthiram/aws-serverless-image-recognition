# aws-serverless-image-recognition
To use Amazon Rekognition to analyze an image uploaded on S3, using Lambda services.

1) AWS CLI setup (Admin User)
    - Reference - https://github.com/aws/aws-cli
    - AWS configure - Create IAM user in your account. Give administrative access (to get access for all AWS services). Create Access Key in Security Credentials. Use this access key details inside $USER/.aws/credentials. Choose a region and add into $USER/.aws/config. When using cmd prompt in Windows, awscli commands should work right away, as it will look for the credentials inside the $USER folder. But when using git bash, the root location is different. So export the following environment variables.
        ```
        export AWS_SHARED_CREDENTIALS_FILE=$USER/.aws/credentials
        export AWS_CONFIG_FILE=$USER/.aws/config
        ```

2) Create Lambda Function
    - Create: Run create_lambda_function.sh script to create a lambda function with parameters set in lambda_resources_define.sh
    - Update: Run update_lambda_function.sh script to update the lambda function code/parameters (again from lambda_resources_define.sh)
    - Permissions: The role assigned to this function has Rek & S3 - RO - access policies attached. Also CloudWatchLogs policy attached to view logs on CloudWatch.
    - Testing: The lambda function can be invoked using CLI or through lambda console (using a test json)

3) Lambda function calls rekognition.detectLabels API for image in S3 bucket.
    - Region: Since rekognition API is not supported in us-west-1, needed to use us-west-2 as region (even though lambda function is present in us-west-1)
    - S3 access: The bucket also needed to be in same region as in rekogntion. Buckets in other regions not accessible by rekognition APIs.

4) S3 image upload triggers lambda function. Use the create_s3_trigger_event.sh script that takes s3 resource parameters from s3_resources_define.sh.
    - Add trigger: Use lambda add permission (lambda trigger) to allow s3 to invoke it.
    - Configure the trigger event from S3. Like what prefix/suffix of objects should trigger the event.
    - Use CloudWatch to look at the logs to find out if lambda got triggered when the right image is uploaded to the s3 bucket.
    - Use uplaod_to_s3.sh script to upload the image into the s3 bucket.