# Day 37: Managing EC2 Access with S3 Role-based Permissions

## 🎯 Objective
The Nautilus DevOps team needs to set up an application on an EC2 instance to interact with an S3 bucket for storing and retrieving data. To achieve this, the team must create a private S3 bucket, set appropriate IAM policies and roles, and test the application functionality.

Task:
1) EC2 Instance Setup:

An instance named datacenter-ec2 already exists.
The instance requires access to an S3 bucket.
2) Setup SSH Keys:

Create new SSH key pair (id_rsa and id_rsa.pub) on the aws-client host and add the public key to the root user's authorized keys on the EC2 instance.
3) Create a Private S3 Bucket:

Name the bucket datacenter-s3-766182622417.
Ensure the bucket is private.
4) Create an IAM Policy and Role:

Create an IAM policy allowing s3:PutObject, s3:ListBucket and s3:GetObject access to datacenter-s3-766182622417.
Create an IAM role named datacenter-role.
Attach the policy to the IAM role.
Attach this role to the datacenter-ec2 instance.
5) Test the Access:

SSH into the EC2 instance and try to upload a file to datacenter-s3-766182622417 bucket using following command:
aws s3 cp <your-file> s3://datacenter-s3-766182622417/

Now run following command to list the upload file:
aws s3 ls s3://datacenter-s3-766182622417/


### 🛠️ Steps to Complete the Task
1. **Setup SSH Keys**:
   - On the aws-client host, generate a new SSH key pair:
     ```bash
     ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
     ```
   - Copy the public key to the EC2 instance:
     ```bash
     ssh-copy-id -i ~/.ssh/id_rsa.pub root@<EC2_INSTANCE_IP>
     ```
2. **Create a Private S3 Bucket**:
    - Use the AWS CLI to create a private S3 bucket:
        ```bash
        aws s3api create-bucket --bucket datacenter-s3-766182622417 --region <your-region>
        aws s3api put-bucket-acl --bucket datacenter-s3-766182622417 --acl private
        ```

3. **Create an IAM Policy and Role**:
    - Create an IAM policy with the necessary permissions:
        ```json
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Effect": "Allow",
              "Action": [
                "s3:PutObject",
                "s3:ListBucket",
                "s3:GetObject"
              ],
              "Resource": [
                "arn:aws:s3:::datacenter-s3-766182622417",
                "arn:aws:s3:::datacenter-s3-766182622417/*"
              ]
            }
          ]
        }
        ```
    - Create an IAM role and attach the policy:
        ```bash
        aws iam create-role --role-name datacenter-role --assume-role-policy-document file://trust-policy.json
        aws iam put-role-policy --role-name datacenter-role --policy-name S3AccessPolicy --policy-document file://s3-access-policy.json
        ```
    - Attach the role to the EC2 instance:
        ```bash
        aws ec2 associate-iam-instance-profile --instance-id <EC2_INSTANCE_ID> --iam-instance-profile Name=datacenter-role
        ```
4. **Test the Access**:
   - SSH into the EC2 instance:
        ```bash
        ssh -i ~/.ssh/id_rsa root@<EC2_INSTANCE_IP>
        ```
    - Upload a file to the S3 bucket:
        ```bash
        aws s3 cp <your-file> s3://datacenter-s3-766182622417/
        ```
    - List the uploaded file:
        ```bash
        aws s3 ls s3://datacenter-s3-766182622417/
        ``` 

## ✅ Expected Outcome
- The EC2 instance should have the necessary permissions to interact with the S3 bucket.
- The file should be successfully uploaded to the S3 bucket, and it should be listed when
the `aws s3 ls` command is executed.
## 📚 Additional Resource
s

