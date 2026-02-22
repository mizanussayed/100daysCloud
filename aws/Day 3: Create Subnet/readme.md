## Day 3: Create Subnet
task:create one subnet named devops-subnet under default VPC.
Create the resources only in us-east-1 region.

## by AWS Management Console:
1. Go to VPC Dashboard and click on Subnets from the left menu.
2. Click on Create Subnet button.
3. Select the default VPC from the dropdown menu.
4. Enter the subnet name as devops-subnet.
5. Click on Create Subnet button to create the subnet.

vpc-0dc40f59a927066f9

## by command line interface (CLI):
```bash 
aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
 
 # check existing subnet CIDR blocks first (avoid overlap)
 aws ec2 describe-subnets --filters "Name=vpc-id,Values=<your-default-vpc-id>" --query "Subnets[].CidrBlock" --output table

 # then create subnet (cidr block is required)
 aws ec2 create-subnet \
    --vpc-id <your-default-vpc-id> \
    -- name devops-subnet \
    --availability-zone us-east-1a \
    --cidr-block 10.0.1.0/24 \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=devops-subnet}]'
```
get list of subnets to verify the subnet is created successfully:
```bash
aws ec2 describe-subnets --filters "Name=vpc-id,Values=<your-default-vpc-id>" --query "Subnets[?CidrBlock=='10.0.1.0/24']"
```
