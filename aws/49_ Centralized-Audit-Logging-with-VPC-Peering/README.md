# Day 49: Centralized Audit Logging with VPC Peering

## 🎯 Objective
The Nautilus datacenter team needs to build a secure and scalable log aggregation setup within their AWS environment. The goal is to gather log files from an internal EC2 instance running in a private VPC, transfer them securely to another EC2 instance in a public VPC, and then push those logs to a secure S3 bucket.

1) A VPC named `datacenter-priv-vpc` already exists with a private subnet named    `datacenter-priv-subnet`, a route table named `datacenter-priv-rt`, and an EC2 instance named `datacenter-priv-ec2` (using ubuntu image). This instance uses the SSH key pair `datacenter-key.pem` already available on the AWS client host at /root/.ssh/.

2) Your task is to:

    - Create a new VPC named `datacenter-pub-vpc`.
    - Create a subnet named `datacenter-pub-subnet` and a route table named `datacenter-pub-rt` under this public VPC.
    - Attach an internet gateway to `datacenter-pub-vpc` and configure the public route table to enable internet access.
    - Launch an EC2 instance named `datacenter-pub-ec2` into the public subnet using the same key pair as the private instance.
    - Create an IAM role named `datacenter-s3-role` with `PutObject` permission to an S3 bucket and attach it to the public EC2 instance.
    - Create a new private S3 bucket named `datacenter-s3-logs-27658`.
    - Configure a VPC Peering named `datacenter-vpc-peering` between the private and public VPCs.
    - Modify both `datacenter-priv-rt` and `datacenter-pub-rt` to route each other's CIDR blocks through the peering connection.
    - On the private instance, configure a cron job to push the /var/log/boots.log file to the public instance (using scp or rsync).
    - On the public instance, configure a cron job to push that same file to the created S3 bucket.

The uploaded file must be stored in the S3 bucket under the path `datacenter-priv-vpc/boot/boots.log`.

## Solution Steps

### Public EC2 instance
```bash
chmod 400 /root/.ssh/datacenter-key.pem
ssh -i /root/.ssh/datacenter-key.pem ec2-user@<PUBLIC-IP>

## install cron and aws-cli on public EC2 instance
sudo yum update -y
sudo yum install -y cronie aws-cli
sudo systemctl start crond
sudo systemctl enable crond
```
### Prepare Private EC2
Connect via jump host:
```bash
cp /root/.ssh/datacenter-key.pem ~/.ssh/id_rsa
ssh ubuntu@<PRIVATE-IP> -J ec2-user@<PUBLIC-IP>

## install cronjob on Ubuntu EC2 instance
sudo apt update
sudo apt install -y cron
sudo systemctl start cron
sudo systemctl enable cron
```

### Setup SSH Key for Automation (CRITICAL) On private EC2:

```bash
mkdir -p ~/.ssh

# Paste contents of datacenter-key.pem from AWS client host
vi ~/.ssh/id_rsa

chmod 400 ~/.ssh/id_rsa
scp -i ~/.ssh/id_rsa /var/log/boots.log ec2-user@<PUBLIC-PRIVATE-IP>:/home/ec2-user/boots.log

# Add cron job to push logs to public EC2 instance every minute
crontab -e
* * * * * scp -i ~/.ssh/id_rsa /var/log/boots.log ec2-user@<PUBLIC-PRIVATE-IP>:/home/ec2-user/
```

### Setup Cron Job on Public EC2 to Push Logs to S3
```bash
crontab -e
* * * * * aws s3 cp /home/ec2-user/boots.log s3://datacenter-s3-logs-27658/datacenter-priv-vpc/boot/boots.log
```

## Final Verification
```bash
aws s3 ls s3://datacenter-s3-logs-27658/datacenter-priv-vpc/boot/
```
## video demonstration
[![Centralized Audit Logging with VPC Peering](https://img.youtube.com/vi/FDU-Wjk_n6g/0.jpg)](https://youtu.be/FDU-Wjk_n6g)