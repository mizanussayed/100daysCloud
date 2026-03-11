# Day 20: Create IAM Role for EC2 with Policy Attachment

## 🎯 Create an IAM role as below:

1) IAM role name must be iamrole_ammar.

2) Entity type must be AWS Service and use case must be EC2.

3) Attach a policy named iampolicy_ammar.

## 🔧 Steps to Create IAM Role and Attach Policy
1. **Create the IAM Role**:

from ui:
- Go to the AWS Management Console and navigate to the IAM service.
- Click on "Roles" in the left sidebar, then click on "Create role".
- Select "AWS service" as the type of trusted entity, and choose "EC2" as the use case.
- Click "Next: Permissions" and then "Next: Tags" (you can skip adding tags).
- Click "Next: Review", enter "iamrole_ammar" as the role name, and click "Create role".

from CLI:
```bash
aws iam create-role --role-name iamrole_ammar --assume-role-policy-document file://trust-policy.json
```
2. **Create the Policy**:
```bash
aws iam create-policy --policy-name iampolicy_ammar --policy-document file://permissions-policy.json
```
3. **Attach the Policy to the Role**:
```bash
aws iam attach-role-policy --role-name iamrole_ammar --policy-arn arn:aws:iam::aws:policy/iampolicy_ammar
```

