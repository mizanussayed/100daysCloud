# Day 47: Integrating AWS SQS and SNS for Reliable Messaging

## 🎯 Objective
Describe what this AWS lab accomplishes.
The Nautilus DevOps team needs to implement priority queuing using Amazon SQS and SNS. The goal is to create a system where messages with different priorities are handled accordingly. You are required to use AWS CloudFormation to deploy the necessary resources in your AWS account. The CloudFormation template should be created on the AWS client host at /root/xfusion-priority-stack.yml, the stack name must be xfusion-priority-stack and it should create the following resources:

1. Two SQS queues named xfusion-High-Priority-Queue and xfusion-Low-Priority-Queue.
2. An SNS topic named xfusion-Priority-Queues-Topic.
3. A Lambda function named xfusion-priorities-queue-function that will consume messages from the SQS queues. The Lambda function code is provided in /root/index.py on the AWS client host.
4. An IAM role named lambda_execution_role that provides the necessary permissions for the Lambda function to interact with SQS and SNS.

Once the stack is deployed, to test the same you can publish messages to the SNS topic, invoke the Lambda function and observe the order in which they are processed by the Lambda function. The high-priority message must be processed first.

```bash
topicarn=$(aws sns list-topics --query "Topics[?contains(TopicArn, 'xfusion-Priority-Queues-Topic')].TopicArn" --output text)

aws sns publish --topic-arn $topicarn --message 'High Priority message 1' --message-attributes '{"priority" : { "DataType":"String", "StringValue":"high"}}'

aws sns publish --topic-arn $topicarn --message 'High Priority message 2' --message-attributes '{"priority" : { "DataType":"String", "StringValue":"high"}}'

aws sns publish --topic-arn $topicarn --message 'Low Priority message 1' --message-attributes '{"priority" : { "DataType":"String", "StringValue":"low"}}'

aws sns publish --topic-arn $topicarn --message 'Low Priority message 2' --message-attributes '{"priority" : { "DataType":"String", "StringValue":"low"}}'
```


## 🧑‍💻 Instructions

1. Create a CloudFormation template named xfusion-priority-stack.yml with the required resources.
2. Deploy the CloudFormation stack using the AWS CLI.
3. Publish messages to the SNS topic with different priorities.
4. Invoke the Lambda function and verify that high-priority messages are processed before low-priority messages.

## 🧑‍🔧 Solution
Package the separate Lambda source file, create & upload it to S3, and deploy the stack with AWS CLI:
```bash
aws s3 mb s3://<your-s3-bucket-name>
zip -j xfusion-function.zip index.py
aws s3 cp xfusion-function.zip s3://<your-s3-bucket-name>/xfusion-function.zip

aws cloudformation deploy --template-file /root/xfusion-priority-stack.yml --stack-name xfusion-priority-stack --capabilities CAPABILITY_NAMED_IAM --parameter-overrides LambdaCodeBucket=<your-s3-bucket-name> LambdaCodeKey=xfusion-function.zip
```



