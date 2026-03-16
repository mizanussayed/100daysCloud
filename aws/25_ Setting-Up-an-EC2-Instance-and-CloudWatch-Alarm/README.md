# Day 25: Setting Up an EC2 Instance and CloudWatch Alarm

## 🎯 The Nautilus DevOps team has been tasked with setting up an EC2 instance for their application. To ensure the application performs optimally, they also need to create a CloudWatch alarm to monitor the instance's CPU utilization. The alarm should trigger if the CPU utilization exceeds 90% for one consecutive 5-minute period. To send notifications, use the SNS topic named devops-sns-topic which is already created.

Launch EC2 Instance: Create an EC2 instance named devops-ec2 using any appropriate Ubuntu AMI.

Create CloudWatch Alarm: Create a CloudWatch alarm named devops-alarm with the following specifications:

Statistic: Average
Metric: CPU Utilization
Threshold: >= 90% for 1 consecutive 5-minute period.
Alarm Actions: Send a notification to devops-sns-topic.


### Step 1: Launch EC2 Instance
To launch an EC2 instance, follow these steps:
1. Go to the AWS Management Console and navigate to the EC2 service.
2. Click on "Launch Instance" and select an appropriate Ubuntu AMI.


### Step 2: Create CloudWatch Alarm
To create a CloudWatch alarm, follow these steps:
1. Go to the AWS Management Console and navigate to the CloudWatch service.
2. Click on "Alarms" in the left-hand menu and then click "Create Alarm".
3. Click on "Select metric" and choose "EC2" > "Per-Instance Metrics" > "CPUUtilization".
4. Select the metric for the devops-ec2 instance and click "Select metric".
5. Configure the alarm settings:
    - Statistic: Average
    - Period: 5 minutes
    - Threshold: >= 90%
    - Datapoints to alarm: 1 out of 1
6. Click "Next" and then select "SNS topic" as the notification method.
7. Choose the existing SNS topic named devops-sns-topic and click "Next".
8. Review the alarm configuration and click "Create alarm" to finalize the setup.
## by command line interface (CLI):
1. To launch an EC2 instance, use the following command:
```bash
aws ec2 run-instances --image-id <AMI-ID> --count 1 --instance-type t2.micro --key-name <KeyPairName> --security-group-ids <SecurityGroupID> --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=devops-ec2}]'
```
1. To create a CloudWatch alarm, use the following command:
```bash
aws cloudwatch put-metric-alarm --alarm-name devops-alarm --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 300 --threshold 90 --comparison-operator GreaterThanOrEqualToThreshold --evaluation-periods 1 --alarm-actions <SNS-Topic-ARN>
```

#3 To verify the alarm is set up correctly, you can use the following command:
```bash
aws cloudwatch describe-alarms --alarm-names devops-alarm
```

