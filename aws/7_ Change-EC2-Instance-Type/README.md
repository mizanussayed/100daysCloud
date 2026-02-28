# Day 7: Change EC2 Instance Type

### task:
1) Change the instance type from t2.micro to t2.nano for nautilus-ec2 instance.
2) Make sure the ec2 instance nautilus-ec2 is in running state after the change.

### solution:
1) Stop the EC2 instance `nautilus-ec2`:
   - Go to the EC2 Dashboard in the AWS Management Console.
   - Select the instance `nautilus-ec2`.
   - Click on "Actions" > "Instance State" > "Stop".
   - Confirm the action to stop the instance.
   - Wait for the instance to stop completely.

2) Change the instance type to `t2.nano`:
    - With the instance still selected, click on "Actions" > "Instance Settings" > "Change Instance Type".
    - In the "Change Instance Type" dialog, select `t2.nano` from the dropdown menu.
    - Click on "Apply" to save the changes.

## By terminal:
1) Get the EC2 instance:
```bash
aws ec2 describe-instances --filters "Name=tag:Name,Values=nautilus-ec2"
```
2) Stop the EC2 instance:
```bash
aws ec2 stop-instances --instance-ids <instance-id>
```
3) Wait for the instance to stop:
```bash
aws ec2 wait instance-stopped --instance-ids <instance-id>
```
4) Change the instance type:
```bash
aws ec2 modify-instance-attribute --instance-id <instance-id> --instance-type "{\"Value\": \"t2.nano\"}"
```
5) Start the EC2 instance:
```bash
aws ec2 start-instances --instance-ids <instance-id>
```