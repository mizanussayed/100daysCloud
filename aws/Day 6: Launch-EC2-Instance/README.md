# Day 6: Launch EC2 Instance
## task:

 create an EC2 instance with following requirements:

1) The name of the instance must be xfusion-ec2.
2) You can use the Amazon Linux AMI to launch this instance.
3) The Instance type must be t2.micro.
4) Create a new RSA key pair named xfusion-kp.
5) Attach the default (available by default) security group.


## Solution:
1) Go to the EC2 dashboard and click on "Launch Instance".
2) In the "Choose an Amazon Machine Image (AMI)" step, select the Amazon Linux AMI.
3) In the "Choose an Instance Type" step, select t2.micro and click "Next: Configure Instance Details".
4) In the "Configure Instance Details" step, you can leave the default settings and click "Next: Add Storage".
5) In the "Add Storage" step, you can leave the default settings and click "Next: Add Tags".
6) In the "Add Tags" step, click on "Add Tag" and enter "Name" as the key and "xfusion-ec2" as the value. Then click "Next: Configure Security Group".
7) In the "Configure Security Group" step, select "Select an existing security group" and choose the default security group. Then click "Review and Launch".

## By commnad line:
1) Create a new RSA key pair named xfusion-kp:
```bash
aws ec2 create-key-pair --key-name xfusion-kp --query 'KeyMaterial' --output text > xfusion-kp.pem
```
2) Launch an EC2 instance with the specified requirements:
```bash
AMI_ID=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].Value' --output text)
aws ec2 run-instances --image-id "$AMI_ID" --count 1 --instance-type t2.micro --key-name xfusion-kp --security-groups default --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=xfusion-ec2}]'
```