# Day 26: Configuring an EC2 Instance as a Web Server with Nginx

## 🎯 task is to create an EC2 instance using AWS CLI with the following specifications:
- Instance Name: The EC2 instance must be named xfusion-ec2.
- Image: Use any available Ubuntu AMI.
- User Data: Configure the EC2 instance to run a startup script that:
    - Installs Nginx.
    - Enables and starts the Nginx service.
- Security Group: Allow HTTP traffic on port 80 from the internet.


## Solution:
```bash
# get vpc-id for your default VPC
VPC_ID=$(aws ec2 describe-vpcs \
    --region <region> \
    --filters Name=isDefault,Values=true \
    --query 'Vpcs[0].VpcId' \
    --output text)

# create security group for HTTP access
aws ec2 create-security-group \
    --region eastus \
    --group-name xfusion-sg \
    --description "Security group for xfusion-ec2" \
    --vpc-id $VPC_ID

# allow inbound HTTP (port 80) from internet
aws ec2 authorize-security-group-ingress \
    --region eastus \
    --group-name xfusion-sg \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

# create user data script
cat > user-data.sh <<'EOF'
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF

# launch EC2 instance with user data and tag Name=xfusion-ec2
aws ec2 run-instances \
    --region <region> \
    --image-id <ubuntu-ami-id> \
    --instance-type t2.micro \
    --key-name <key-pair-name> \
    --security-groups xfusion-sg \
    --subnet-id <subnet-id> \
    --user-data file://user-data.sh \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=xfusion-ec2}]'

# wait for xfusion-ec2 instance to be running
aws ec2 wait instance-running \
    --region <region> \
    --filters Name=tag:Name,Values=xfusion-ec2 Name=instance-state-name,Values=pending,running
```

## Verification:
1. Verify the EC2 instance details and public IP:

```bash
aws ec2 describe-instances \
    --region <region> \
    --filters Name=tag:Name,Values=xfusion-ec2 \
    --query "Reservations[].Instances[].{Name:Tags[?Key=='Name']|[0].Value,State:State.Name,PublicIP:PublicIpAddress}"
```
2. Verify security group has HTTP port 80 open:

```bash
aws ec2 describe-security-groups \
    --region <region> \
    --group-names xfusion-sg \
    --query "SecurityGroups[0].IpPermissions"
```
3. Verify Nginx is serving over HTTP:

```bash
curl http://<public-ip>
```