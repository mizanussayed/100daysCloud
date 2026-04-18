# Day 49: Centralized Audit Logging with VPC Peering

## 🎯 Objective
The Nautilus DevOps team needs to build a secure and scalable log aggregation setup within their AWS environment. The goal is to gather log files from an internal EC2 instance running in a private VPC, transfer them securely to another EC2 instance in a public VPC, and then push those logs to a secure S3 bucket.

1) A VPC named `datacenter-priv-vpc` already exists with a private subnet named    `datacenter-priv-subnet`, a route table named `datacenter-priv-rt`, and an EC2 instance named `datacenter-priv-ec2` (using ubuntu image). This instance uses the SSH key pair `datacenter-key.pem` already available on the AWS client host at /root/.ssh/.

2) Your task is to:

    - Create a new VPC named `datacenter-pub-vpc`.
    - Create a subnet named `datacenter-pub-subnet` and a route table named `datacenter-pub-rt` under this public VPC.
    - Attach an internet gateway to `datacenter-pub-vpc` and configure the public route table to enable internet access.
    - Launch an EC2 instance named `datacenter-pub-ec2` into the public subnet using the same key pair as the private instance.
    - Create an IAM role named `datacenter-s3-role` with `PutObject` permission to an S3 bucket and attach it to the public EC2 instance.
    - Create a new private S3 bucket named `datacenter-s3-logs-14417`.
    - Configure a VPC Peering named `datacenter-vpc-peering` between the private and public VPCs.
    - Modify both `datacenter-priv-rt` and `datacenter-pub-rt` to route each other's CIDR blocks through the peering connection.
    - On the private instance, configure a cron job to push the /var/log/boots.log file to the public instance (using scp or rsync).
    - On the public instance, configure a cron job to push that same file to the created S3 bucket.

The uploaded file must be stored in the S3 bucket under the path `datacenter-priv-vpc/boot/boots.log`.

## Solution Steps

## install cronjob on both EC2 instances
```bash
ssh -i /root/.ssh/datacenter-key.pem ubuntu@<ec2-public-ip>
sudo apt-get update
sudo apt-get install cron -y
sudo service cron start
sudo service cron status
```

## Edit Crontab on Private EC2 Instance
```bash
ssh -i /root/.ssh/datacenter-key.pem ubuntu@<private-ec2-private-ip>
crontab -e
## Add the following line
* * * * * scp -i /root/.ssh/datacenter-key.pem /var/log/boots.log ubuntu@<public-ec2-public-ip>:/home/ubuntu/
```
## Edit Crontab on Public EC2 Instance
```bash
ssh -i /root/.ssh/datacenter-key.pem ubuntu@<public-ec2-public-ip>
crontab -e
* * * * * aws s3 cp /home/ubuntu/boots.log s3://datacenter-s3-logs-14417/datacenter-priv-vpc/boot/boots.log
```


