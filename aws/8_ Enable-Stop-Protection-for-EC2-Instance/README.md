# Day 8: Enable Stop Protection for EC2 Instance
### task:
As part of the migration, there were some components added to the AWS account. Team created one of the EC2 instances where they need to make some changes now.
There is an EC2 instance named datacenter-ec2 under us-east-1 region, enable the stop protection for this instance.

### solution:
1. Go to AWS Management Console, navigate to EC2 service, and click Instances in the
left navigation pane.
2. Select the instance datacenter-ec2, click Actions, select Instance Settings, and click Change Stop Protection.
3. In the pop-up window, select Enable and click Save. 

### By Command Line Interface (CLI):
```bash
#  get the instance ID of datacenter-ec2
aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=datacenter-ec2" \
    --query "Reservations[*].Instances[*].InstanceId" \
    --output text


aws ec2 modify-instance-attribute \
  --instance-id <instance-id> \
  --no-disable-api-termination
```
Note: Replace <instance-id> with the actual instance ID of datacenter-ec2.

