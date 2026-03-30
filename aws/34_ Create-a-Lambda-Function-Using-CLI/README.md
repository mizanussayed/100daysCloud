# Day 34: Create a Lambda Function Using CLI

## 🎯 Objective
The Nautilus DevOps team continues to explore serverless architecture by setting up another Lambda function. This time, the task must be completed using the AWS Console to familiarize the team with the web interface. The function will return a custom greeting and demonstrate the capabilities of AWS Lambda effectively.

- Create a Python script named lambda_function.py with a function that returns the body Welcome to KKE AWS Labs! and status code 200.

-  Zip the script into a file named function.zip.

-  Create a Lambda function named xfusion-lambda-cli using the zipped file and specify Python as the runtime.

- IAM Role: Use the IAM role named lambda_execution_role.

## 🛠️ Steps to Create a Lambda Function Using CLI
1. **Create the Python Script**: Create a file named `lambda_function.py` with the following content:

```python
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Welcome to KKE AWS Labs!'
    }
```
2. **Zip the Python Script**: Use the following command to zip the script:

```bash
zip function.zip lambda_function.py
```


3. **Create the Lambda Function**: Use the AWS CLI to create the Lambda function with the following command:

```bash
# get the ARN of the IAM role
ROLE_ARN=$(aws iam get-role --role-name lambda_execution_role --query 'Role.Arn' --output text)

aws lambda create-function --function-name xfusion-lambda-cli \
--runtime python3.8 \
--role arn:aws:iam::863718742279:role/lambda_execution_role \
--handler lambda_function.lambda_handler \
--zip-file fileb://function.zip
```
4. **Verify the Lambda Function**: After creating the function, you can verify it by invoking it using the following command:

```bash
aws lambda invoke --function-name xfusion-lambda-cli output.txt
```