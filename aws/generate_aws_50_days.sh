#!/bin/bash

titles=(
"Create Key Pair 1"
"Create Security Group 1"
"Create Subnet 1"
"Enable Versioning for S3 Bucket"
"Create GP3 Volume"
"Launch EC2 Instance"
"Change EC2 Instance Type"
"Enable Stop Protection for EC2 Instance"
"Enable Termination Protection for EC2 Instance"
"Attach Elastic IP to EC2 Instance"
"Attach Elastic Network Interface to EC2 Instance"
"Attach Volume to EC2 Instance"
"Create AMI from EC2 Instance"
"Terminate EC2 Instance"
"Create Volume Snapshot"
"Create IAM User"
"Create IAM Group"
"Create Read-Only IAM Policy for EC2 Console Access"
"Attach IAM Policy to IAM User"
"Create IAM Role for EC2 with Policy Attachment"
"Setting Up an EC2 Instance with an Elastic IP for Application Hosting"
"Configuring Secure SSH Access to an EC2 Instance"
"Data Migration Between S3 Buckets Using AWS CLI"
"Setting Up an Application Load Balancer for an EC2 Instance"
"Setting Up an EC2 Instance and CloudWatch Alarm"
"Configuring an EC2 Instance as a Web Server with Nginx"
"Configuring a Public VPC with an EC2 Instance for Internet Access"
"Creating a Private ECR Repository"
"Establishing Secure Communication Between Public and Private VPCs via VPC Peering"
"Enable Internet Access for Private EC2 using NAT Instance"
"Configuring a Private RDS Instance for Application Development"
"Snapshot and Restoration of an RDS Instance"
"Create a Lambda Function"
"Create a Lambda Function Using CLI"
"Deploying and Managing Applications on AWS"
"Load Balancing EC2 Instances with Application Load Balancer"
"Managing EC2 Access with S3 Role-based Permissions"
"Deploying Containerized Applications with Amazon ECS"
"Hosting a Static Website on AWS S3"
"Troubleshooting Internet Accessibility for an EC2-Hosted Application"
"Securing Data with AWS KMS"
"Building and Managing NoSQL Databases with AWS DynamoDB"
"Scaling and Managing Kubernetes Clusters with Amazon EKS"
"Implementing Auto Scaling for High Availability in AWS"
"Configure NAT Gateway for Internet Access in a Private VPC"
"Event-Driven Processing with Amazon S3 and Lambda"
"Integrating AWS SQS and SNS for Reliable Messaging"
"Automating Infrastructure Deployment with AWS CloudFormation"
"Centralized Audit Logging with VPC Peering"
"Expanding EC2 Instance Storage for Development Needs"
)

for i in "${!titles[@]}"; do
    day=$((i+1))
    title="${titles[$i]}"

    folder="Day-${day} : $(echo "$title" | tr ' ' '-' | tr -cd '[:alnum:]-')"

    mkdir -p "$folder"

    cat <<EOF > "$folder/README.md"
# Day ${day}: ${title}

## 🎯 Objective
Describe what this AWS lab accomplishes.

## 🛠 Steps Performed
1.
2.
3.

## 💻 Commands Used
\`\`\`bash

\`\`\`

## 🧠 Concepts Covered
- 

## ✅ Outcome
What was successfully achieved?

EOF

done

echo "✅ 50 AWS Day folders created successfully!"