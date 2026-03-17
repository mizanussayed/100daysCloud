# Day 25: Setting Up an EC2 Instance and CloudWatch Alarm

## 🎯 task is to create an EC2 instance and configure a CloudWatch alarm using AWS CLI with the following specifications:

- Instance Name: The EC2 instance must be named devops-ec2.
- Image: Use any available Ubuntu AMI.
- Alarm Name: Create a CloudWatch alarm named devops-alarm.
- Metric: CPUUtilization for the created EC2 instance.
- Statistic and Period: Average over 5 minutes.
- Threshold: Trigger when CPU utilization is greater than or equal to 90%.
- Evaluation: 1 consecutive period.
- Notification: Send alarm notifications to the existing SNS topic devops-sns-topic.

Instructions:

Use AWS CLI commands to launch the EC2 instance and create the alarm.
Ensure the alarm is linked to the correct EC2 instance and SNS topic.
Use verification commands to confirm both resources are created correctly.

## Solution:
```bash
# set your AWS region
AWS_REGION=<region>

# get Ubuntu AMI ID from AWS SSM (Ubuntu 22.04 LTS)
AMI_ID=$(aws ssm get-parameter \
    --name /aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id \
    --region $AWS_REGION \
    --query 'Parameter.Value' \
    --output text)

# launch EC2 instance named devops-ec2
# replace placeholders with valid values from your environment
INSTANCE_ID=$(aws ec2 run-instances \
    --region $AWS_REGION \
    --image-id "$AMI_ID" \
    --instance-type t2.micro \
    --key-name <key-pair-name> \
    --security-group-ids <security-group-id> \
    --subnet-id <subnet-id> \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=devops-ec2}]' \
    --query 'Instances[0].InstanceId' \
    --output text)

# wait until instance is running
aws ec2 wait instance-running \
    --region $AWS_REGION \
    --instance-ids "$INSTANCE_ID"

# get SNS topic ARN for devops-sns-topic
TOPIC_ARN=$(aws sns list-topics \
    --region $AWS_REGION \
    --query "Topics[?contains(TopicArn, 'devops-sns-topic')].TopicArn | [0]" \
    --output text)

# create CloudWatch alarm
aws cloudwatch put-metric-alarm \
    --region $AWS_REGION \
    --alarm-name devops-alarm \
    --alarm-description "Alarm when EC2 CPU >= 90% for 5 minutes" \
    --namespace AWS/EC2 \
    --metric-name CPUUtilization \
    --dimensions Name=InstanceId,Value="$INSTANCE_ID" \
    --statistic Average \
    --period 300 \
    --evaluation-periods 1 \
    --threshold 90 \
    --comparison-operator GreaterThanOrEqualToThreshold \
    --alarm-actions "$TOPIC_ARN" \
    --treat-missing-data missing
```

## Verification:
1. Verify the EC2 instance named devops-ec2:
```bash
aws ec2 describe-instances \
    --region $AWS_REGION \
    --filters "Name=tag:Name,Values=devops-ec2" \
    --query "Reservations[].Instances[].{InstanceId:InstanceId,State:State.Name,Name:Tags[?Key=='Name']|[0].Value}"
```
2. Verify the CloudWatch alarm configuration:
```bash
aws cloudwatch describe-alarms \
    --region $AWS_REGION \
    --alarm-names devops-alarm
```
3. Verify alarm action points to devops-sns-topic:
```bash
aws cloudwatch describe-alarms \
    --region $AWS_REGION \
    --alarm-names devops-alarm \
    --query "MetricAlarms[0].AlarmActions"
```

