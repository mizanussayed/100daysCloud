# Create Security Group
### Task 
- create a security group under default VPC with the following requirements:
- Name of the security group is datacenter-sg.
- The description must be Security group for Nautilus App Servers
- Add the inbound rule of type HTTP, with port range of 80. Enter the source CIDR range of 0.0.0.0/0.
- Add another inbound rule of type SSH, with port range of 22. Enter the source CIDR range of 0.0.0.0/0.

## Step 1: Create a Security Group
1. Open the Amazon EC2 console at [https://console.aws.amazon.com/ec2/](https://console.aws.amazon.com/ec2/).
2. In the navigation pane, choose **Security Groups**.
3. Click on the **Create security group** button.
4. In the **Create Security Group** dialog box, enter the following details:
   - **Security group name**: `datacenter-sg`
   - **Description**: `Security group for Nautilus App Servers`
   - **VPC**: Select the default VPC.
5. Click on the **Create** button to create the security group.
## Step 2: Add Inbound Rules
1. After creating the security group, select it from the list of security groups.
2. Click on the **Inbound rules** tab, then click on the **Edit inbound rules** button.
3. In the **Edit inbound rules** dialog box, click on the **Add rule** button.
4. For the new rule, enter the following details:
   - **Type**: Select the type of traffic you want to allow (e.g., **HTTP** for port 80).
   - **Protocol**: This will be automatically filled based on the type you selected.
   - **Port range**: This will also be automatically filled based on the type you selected.
   - **Source**: Select the source of the traffic (e.g., **Anywhere** to allow traffic from any IP address).
5. Click on the **Save rules** button to save the inbound rule.
6. Repeat steps 3-5 to add additional rules as needed (e.g., **SSH** for port 22).


## By command line
1. Create a security group:
```bash
aws ec2 create-security-group --group-name datacenter-sg --description "Security group for Nautilus App Servers" --vpc-id vpc-xxxxxxxx
```
2. Add an inbound rule to allow HTTP traffic:
```bash
aws ec2 authorize-security-group-ingress --group-id sg-xxxxxxxx --protocol tcp --port 80 --cidr 0.0.0.0/0
```
3. Add an inbound rule to allow SSH traffic:
```bash
aws ec2 authorize-security-group-ingress --group-id sg-xxxxxxxx --protocol tcp --port 22 --cidr 0.0.0.0/0
```

## here cidr means Classless Inter-Domain Routing, which is a method for allocating IP addresses and routing Internet Protocol packets. In this case, `

## Get Security Group ID
To get the security group ID, you can use the following command:
```bash
aws ec2 describe-security-groups --group-names datacenter-sg --query 'SecurityGroups[0].GroupId' --output text
```