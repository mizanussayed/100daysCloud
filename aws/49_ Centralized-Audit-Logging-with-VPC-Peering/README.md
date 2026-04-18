# Day 49: Centralized Audit Logging with VPC Peering

## 🎯 Objective
The Nautilus DevOps team needs to build a secure and scalable log aggregation setup within their AWS environment. The goal is to gather log files from an internal EC2 instance running in a private VPC, transfer them securely to another EC2 instance in a public VPC, and then push those logs to a secure S3 bucket.

1) A VPC named `devops-priv-vpc` already exists with a private subnet named    `devops-priv-subnet`, a route table named `devops-priv-rt`, and an EC2 instance named `devops-priv-ec2` (using ubuntu image). This instance uses the SSH key pair `devops-key.pem` already available on the AWS client host at /root/.ssh/.

2) Your task is to:

    - Create a new VPC named `devops-pub-vpc`.
    - Create a subnet named `devops-pub-subnet` and a route table named `devops-pub-rt` under this public VPC.
    - Attach an internet gateway to `devops-pub-vpc` and configure the public route table to enable internet access.
    - Launch an EC2 instance named `devops-pub-ec2` into the public subnet using the same key pair as the private instance.
    - Create an IAM role named `devops-s3-role` with `PutObject` permission to an S3 bucket and attach it to the public EC2 instance.
    - Create a new private S3 bucket named `devops-s3-logs-14417`.
    - Configure a VPC Peering named `devops-vpc-peering` between the private and public VPCs.
    - Modify both `devops-priv-rt` and `devops-pub-rt` to route each other's CIDR blocks through the peering connection.
    - On the private instance, configure a cron job to push the /var/log/boots.log file to the public instance (using scp or rsync).
    - On the public instance, configure a cron job to push that same file to the created S3 bucket.

The uploaded file must be stored in the S3 bucket under the path `devops-priv-vpc/boot/boots.log`.

## Solution Steps

### ssh & jump host setup to access private EC2 instance
```bash
## First, we will access the public EC2 instance using the SSH key pair
ssh -i /root/.ssh/devops-key.pem ubuntu@10.11.1.186

## exit from public EC2 instance
exit
cp .ssh/devops-key.pem /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

## Now we will use this public EC2 instance as a jump host to access the private EC2 instance
ssh ubuntu@10.11.2.186 -J ubuntu@10.11.1.186
ssh-keygen -t ed25519
```


## install cronjob on ubuntu EC2 instances
```bash
ssh -i /root/.ssh/devops-key.pem ubuntu@10.11.1.186
sudo apt-get update
sudo apt-get install cron -y
sudo service cron start
sudo service cron status
```

## install cronjob on Amazon Linux EC2 instances
```bash
ssh -i /root/.ssh/devops-key.pem ec2-user@10.11.1.186
sudo yum update -y
sudo yum install cronie -y
sudo service crond start
sudo service crond status
```

## Edit Crontab on Private EC2 Instance
```bash
ssh -i /root/.ssh/devops-key.pem ubuntu@10.11.1.186
crontab -e
## Add the following line
* * * * * scp  /var/log/boots.log ubuntu@10.11.1.186:/home/ubuntu/
```
## Edit Crontab on Public EC2 Instance
```bash
ssh -i /root/.ssh/devops-key.pem ubuntu@10.11.1.186
crontab -e
* * * * * aws s3 cp /home/ubuntu/boots.log s3://devops-s3-logs-14417/devops-priv-vpc/boot/boots.log
```


