# Day 14: Terminate EC2 Instance

1) Delete the ec2 instance named xfusion-ec2 present in us-east-1 region.

2) Before submitting your task, make sure instance is in terminated state.

## Solution:
1. Go to the AWS Management Console and navigate to the EC2 service.
2. In the left-hand menu, click on "Instances" to view all your EC2 instances.
3. Locate the instance named "xfusion-ec2" in the list of instances.
4. Select the instance by clicking the checkbox next to it.
5. Click on the "Actions" button at the top of the page, then select "Instance State" and choose "Terminate" from the dropdown menu.
6. Confirm the termination by clicking "Yes, Terminate" in the confirmation dialog.

## by command line:
```bash
aws ec2 terminate-instances --instance-ids <instance-id>
```