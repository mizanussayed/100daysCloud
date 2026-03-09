# Day 18: Create Read-Only IAM Policy for EC2 Console Access

- Create an IAM policy named iampolicy_kirsty in us-east-1 region, 
- it must allow read-only access to the EC2 console, i.e 
- this policy must allow users to view all instances, AMIs, and snapshots in the Amazon EC2 console.

## Steps to Create Read-Only IAM Policy for EC2 Console Access

1. In the left navigation pane, choose Policies.
2. Choose Create policy.
3. On the Create policy page, choose the JSON tab.
4. Copy and paste the following JSON policy document into the JSON editor:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
            ],
            "Resource": "*"
        }
    ]
}
```
5. follow the prompts to review and create the policy, and name it iampolicy_kirsty.

## by cli 
```bash
aws iam create-policy --policy-name iampolicy_kirsty --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*"
            ],
            "Resource": "*"
        }
    ]
}'
```
## by terraform
```hcl
resource "aws_iam_policy" "iampolicy_kirsty" {
    name        = "iampolicy_kirsty"
    description = "Read-only access to EC2 console"
    policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "ec2:Describe*"
                ],
                Resource = "*"
            }
        ]
    })
}
```

