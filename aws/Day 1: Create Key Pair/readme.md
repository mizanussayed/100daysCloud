## Day 1: Create Key Pair

### task: Create a key pair in AWS.
- Name of the key pair should be devops-kp.
- Key pair type must be rsa


### Solution:```bash
aws ec2 create-key-pair --key-name devops-kp --key-type rsa
```