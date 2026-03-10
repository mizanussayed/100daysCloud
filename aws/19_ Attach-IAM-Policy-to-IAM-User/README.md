# Day 19: Attach IAM Policy to IAM User

## 🎯
An IAM user named iamuser_kareem and a policy named iampolicy_kareem already exist. Attach the IAM policy iampolicy_kareem to the IAM user iamuser_kareem.

## 🧑‍💻 Solution:

### Using AWS CLI:

```bash
aws iam attach-user-policy --user-name iamuser_kareem --policy-arn arn:aws:iam::aws:policy/iampolicy_kareem
```

### Using AWS Management Console:
1. Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/.

2. In the navigation pane, choose "Users".
3. Choose the name of the user (iamuser_kareem) to whom you want to attach the policy.
4. On the "Permissions" tab, choose "Add permissions".
5. Choose "Attach existing policies directly".
6. In the search box, type "iampolicy_kareem" to find the
policy you want to attach.
7. Select the checkbox next to the policy name (iampolicy_kareem).
8. Choose "Next: Review" to see the policies that will be attached to the user
9. If everything looks correct, choose "Add permissions" to attach the policy to the user.

### Using AWS SDK for Python (Boto3):

```python
import boto3
# Create an IAM client
iam = boto3.client('iam')
# Attach the policy to the user
response = iam.attach_user_policy(
    UserName='iamuser_kareem',
    PolicyArn='arn:aws:iam::aws:policy/iampolicy_kareem'
)
print(response)
```

### Using AWS SDK for JavaScript (Node.js):

```javascript
const AWS = require('aws-sdk');
const iam = new AWS.IAM();
const params = {
  UserName: 'iamuser_kareem',
  PolicyArn: 'arn:aws:iam::aws:policy/iampolicy_kareem'
};

iam.attachUserPolicy(params, function(err, data) {
  if (err) console.log(err, err.stack); // an error occurred
  else     console.log(data);           // successful response
});
```

### Using Terraform:
```hcl
resource "aws_iam_user_policy_attachment" "example" {
  user       = "iamuser_kareem"
  policy_arn = "arn:aws:iam::aws:policy/iampolicy_kareem"
}
```

### Using AWS CloudFormation:
```yaml
Resources:
  AttachPolicyToUser:
    Type: AWS::IAM::UserToGroupAddition
    Properties:
      GroupName: iampolicy_kareem
      Users:
        - iamuser_kareem
```
