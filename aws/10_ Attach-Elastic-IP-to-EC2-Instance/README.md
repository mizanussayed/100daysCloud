# Day 10: Attach Elastic IP to EC2 Instance

### task:
There is an instance named nautilus-ec2 and an elastic-ip named nautilus-ec2-eip in us-east-1 region. Attach the nautilus-ec2-eip elastic-ip to the nautilus-ec2 instance.

### solution:
1. Go to the EC2 Dashboard in the AWS Management Console.
2. In the left navigation pane, click on "Elastic IPs" under the "Network
& Security" section.
3. Find the elastic IP named "nautilus-ec2-eip" in the list of elastic IPs.
4. Select the checkbox next to "nautilus-ec2-eip" and click on the "Actions" button.
5. From the dropdown menu, select "Associate Elastic IP address".
6. In the "Associate Elastic IP address" dialog box, select the "Instance" option.
7. From the "Instance" dropdown menu, select the instance named "nautilus-ec2".
8. Click on the "Associate" button to attach the elastic IP to the EC2 instance.


### By Command Line 
```bash
# get the instance ID
aws ec2 describe-instances --filters "Name=tag:Name,Values=nautilus-ec2" --query "Reservations[*].Instances[*].InstanceId" --output text
# get the allocation ID

## crate the elastic IP
aws ec2 allocate-address --domain vpc --tag-specifications 'ResourceType=elastic-ip,Tags=[{Key=Name,Value=nautilus-ec2-eip}]'
aws ec2 describe-addresses --filters "Name=tag:Name,Values=nautilus-ec2-eip" --query "Addresses[*].AllocationId" --output text
## associate the elastic IP to the EC2 instance
aws ec2 associate-address --instance-id <id> --allocation-id <id>
```
