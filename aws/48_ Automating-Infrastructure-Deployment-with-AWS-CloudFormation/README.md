# Day 48: Automating Infrastructure Deployment with AWS CloudFormation

## 🎯 Objective
The Nautilus DevOps team needs to implement a Lambda function using a CloudFormation stack. Create a CloudFormation template named /`root/xfusion-lambda.yml` on the AWS client host and configure it to create the following components. The stack name must be `xfusion-lambda-app`.

1. Create a Lambda function named xfusion-lambda.
2. Use the Runtime Python.
3. The function should print the body Welcome to KKE AWS Labs!.
4. Ensure the status code is 200.
5. Create and use the IAM role named lambda_execution_role.

## 🛠️ Steps to Implement

1. **Create the CloudFormation Template**: Create a file named `xfusion-lambda.yml`

2. **Deploy the CloudFormation Stack**: Use the AWS CLI to deploy the stack.

```bash
aws cloudformation deploy --template-file /root/xfusion-lambda.yml --stack-name xfusion-lambda-app --capabilities CAPABILITY_NAMED_IAM
```
3. **Verify the Deployment**: After the stack is created, verify that the Lambda function is working correctly by invoking it.

```bash
aws lambda invoke --function-name xfusion-lambda output.txt
```


## Video Walkthrough
[![Video Walkthrough](https://img.youtube.com/vi/f2K2i2Lu-zk/0.jpg)](https://youtu.be/f2K2i2Lu-zk)