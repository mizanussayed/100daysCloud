# Day 48: Automating Infrastructure Deployment with AWS CloudFormation

## 🎯 Objective
The Nautilus DevOps team needs to implement a Lambda function using a CloudFormation stack. Create a CloudFormation template named /`root/xfusion-lambda.yml` on the AWS client host and configure it to create the following components. The stack name must be `xfusion-lambda-app`.

1. Create a Lambda function named xfusion-lambda.
2. Use the Runtime Python.
3. The function should print the body Welcome to KKE AWS Labs!.
4. Ensure the status code is 200.
5. Create and use the IAM role named lambda_execution_role.

## 🛠️ Steps to Implement

1. **Create the CloudFormation Template**: Create a file named `xfusion-lambda.yml` and add the following content to define the Lambda function and its execution role.

```yaml
AWSTemplateFormatVersion: '2010-09-09'

Resources:
  LambdaExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: lambda_execution_role
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service:
                - lambda.amazonaws.com
            Action:
              - sts:AssumeRole
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

  XfusionLambdaFunction:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: xfusion-lambda
      Runtime: python3.8
      Role: !GetAtt LambdaExecutionRole.Arn
      Handler: index.handler
      Code:
        ZipFile: |
          def handler(event, context):
              return {
                  'statusCode': 200,
                  'body': 'Welcome to KKE AWS Labs!'
              }
```

2. **Deploy the CloudFormation Stack**: Use the AWS CLI to deploy the stack.

```bash
aws cloudformation create-stack --stack-name xfusion-lambda-app --template-body file://xfusion-lambda.yml
```
3. **Verify the Deployment**: After the stack is created, verify that the Lambda function is working correctly by invoking it.

```bash
aws lambda invoke --function-name xfusion-lambda output.txt
```


## Video Walkthrough
[![Video Walkthrough](https://img.youtube.com/vi/VIDEO_ID/0.jpg)](https://www.youtube.com/watch?v=VIDEO_ID)