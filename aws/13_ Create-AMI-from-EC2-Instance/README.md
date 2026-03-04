# Day 13: Create AMI from EC2 Instance

- create an AMI from an existing EC2 instance named devops-ec2 with the following requirement:
- Name of the AMI should be devops-ec2-ami, make sure AMI is in available state.

## Solution
1. In the AWS Management Console, navigate to the EC2 service.
2. In the left-hand menu, click on "Instances" under the "Instances" section
3. Select the instance named devops-ec2 from the list of instances.
4. Click on the "Actions" button at the top of the page, then select "
Image" and then "Create Image" from the dropdown menu.
5. In the "Create Image" dialog box, enter "devops-ec2-ami" in the "Image name" field.
6. Optionally, you can provide a description for the AMI in the "Image description" field.
7. Ensure that the "No reboot" option is unchecked to allow the instance to reboot during the image creation process.
8. Click on the "Create Image" button to start the AMI creation process.

## Command Line 
```bash
# get the instance ID of the devops-ec2 instance
aws ec2 describe-instances --filters "Name=tag:Name,Values=devops-ec2" --query "Reservations[*].Instances[*].InstanceId" --output text
aws ec2 create-image --instance-id <instance-id> --name "devops-ec2-ami" --description "AMI created from devops-ec2 instance" --no-reboot
## list the AMIs with the name devops-ec2-ami
aws ec2 describe-images --filters "Name=name,Values=devops-ec2-ami" --query "Images[*].{ID:ImageId,State:State}" --output table
```

