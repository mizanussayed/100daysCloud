# Day 5: Create GP3 Volume
## task: Create a volume with the following requirements:
- Name of the volume should be datacenter-volume.
- Volume type must be gp3.
- Volume size must be 2 GiB.
- Create the resources only in us-east-1 region.

### Solution:
1. Open the AWS Management Console and navigate to the EC2 service.
2. In the left-hand menu, click on "Volumes" under the "Elastic Block Store" section.
3. Click on the "Create Volume" button.
4. In the "Create Volume" form, fill in the following details:
- **Volume Type**: Select "gp3" from the dropdown menu.
- **Size**: Enter "2" in the size field and select "GiB" from the dropdown menu.
- **Availability Zone**: Select an availability zone in the us-east-1 region (e.g., us-east-1a).
5. Click on the "Create Volume" button.


## by terminal:
```bash
aws ec2 create-volume --size 2 --volume-type gp3 --availability-zone us-east-1a --tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=datacenter-volume}]'
# get 
aws ec2 describe-volumes --filters "Name=tag:Name,Values=datacenter-volume"
```
