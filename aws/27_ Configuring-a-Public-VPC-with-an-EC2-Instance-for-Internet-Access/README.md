# Day 27: Configuring a Public VPC with an EC2 Instance for Internet Access

## 🎯 task:
- Create a public VPC named nautilus-pub-vpc
- subnet named nautilus-pub-subnet under the same,
- make sure public IP is being auto assigned to resources under this subnet.
- create an EC2 instance named nautilus-pub-ec2 under this VPC with instance type t2.micro.
-  Make sure SSH port 22 is open for this instance and accessible over the internet.

## 🧑‍💻 solution:
1. **Create a VPC**:
   - Go to the VPC Dashboard in the AWS Management Console.
   - Click on "Create VPC".
   - Name it `nautilus-pub-vpc`.
   - Set the IPv4 CIDR block (e.g., `10.0.0.0/16`).
   - Click "Create".

2. **Create a Subnet**:
   - In the VPC Dashboard, click on "Subnets" in the left sidebar.
   - Click "Create Subnet".
   - Select the `nautilus-pub-vpc` VPC.
   - Name it `nautilus-pub-subnet`.
   - Set the IPv4 CIDR block (e.g., `10.0.1.0/24`).
   - Select the Availability Zone.
   - Check "Enable auto-assign public IP" option.
   - Click "Create".

3. **Create an Internet Gateway**:
   - In the VPC Dashboard, click on "Internet Gateways" in the left sidebar.
   - Click "Create Internet Gateway".
   - Name it `nautilus-pub-igw`.
   - Click "Create".
   - Attach the internet gateway to the `nautilus-pub-vpc` VPC.

4. **Update Route Table**:
   - In the VPC Dashboard, click on "Route Tables" in the left sidebar.
   - Select the main route table associated with the `nautilus-pub-vpc` VPC.
   - Click on the "Routes" tab.
   - Click "Edit routes".
   - Add a new route with destination `0.0.0.0/0` and target as the internet gateway (`nautilus-pub-igw`).
   - Click "Save routes".

5. **Create Security Group**:
   - In the VPC Dashboard, click on "Security Groups" in the left sidebar.
   - Click "Create Security Group".
   - Name it `nautilus-pub-sg`.
   - Description: Allow SSH access.
   - VPC: Select `nautilus-pub-vpc`.
   - Add an inbound rule for SSH (port 22) from any IP address (0.0.0.0/0).
   - Click "Create".

6. **Launch EC2 Instance**:
   - Go to the EC2 Dashboard in the AWS Management Console.
   - Click on "Launch Instance".
   - Choose an Amazon Machine Image (AMI).
   - Select instance type `t2.micro`.
   - Configure instance details:
     * Network: Select `nautilus-pub-vpc`.
     * Subnet: Select `nautilus-pub-subnet`.
     * Auto-assign Public IP: Enabled.
     * IAM Role: Leave as default or select an appropriate role if needed.
     * Key Pair: Create or select an existing key pair for SSH access.
     * Security Group: Select `nautilus-pub-sg`.
     * Advanced Details: Leave as default or add user data if needed.


## by command line:
```bash
# Create VPC
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=nautilus-pub-vpc}]'

# Create Subnet
aws ec2 create-subnet --vpc-id <vpc-id> --cidr-block 10.0.1.0/24 --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=nautilus-pub-subnet}]'

# Enable auto-assign public IP
aws ec2 modify-subnet-attribute --subnet-id <subnet-id> --map-public-ip-on-launch

# Create Internet Gateway
aws ec2 create-internet-gateway --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=nautilus-pub-igw}]'
# Attach Internet Gateway to VPC
aws ec2 attach-internet-gateway --internet-gateway-id <igw-id> --vpc-id <vpc-id>
# Update Route Table
aws ec2 create-route --route-table-id <route-table-id> --destination-cidr-block 0.0.0.0/0 --gateway-id <igw-id>

# Create Security Group
aws ec2 create-security-group --group-name nautilus-pub-sg --description "Allow SSH access" --vpc-id <vpc-id>
# Add Inbound Rule for SSH

aws ec2 authorize-security-group-ingress --group-id <sg-id> --protocol tcp --port 22 --cidr 0.0.0.0/0

# Launch EC2 Instance
aws ec2 run-instances --image-id <ami-id> --count 1 --instance-type t2.micro --key-name <key-pair-name> --security-group-ids <sg-id> --subnet-id <subnet-id> --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=nautilus-pub-ec2}]'
```

