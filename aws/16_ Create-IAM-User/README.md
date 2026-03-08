# Day 16: Create IAM User
# task:
 create an IAM user named iamuser_kareem.

## Solution

- From left side of the AWS Management Console, click on Services and then select IAM under Security, Identity, & Compliance.


### by CLI
```bash
aws iam create-user --user-name iamuser_kareem

# verify
aws iam list-users --query "Users[?UserName=='iamuser_kareem'].UserName" --output text
```

