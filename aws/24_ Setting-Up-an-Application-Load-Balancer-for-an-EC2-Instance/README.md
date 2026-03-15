# Day 24: Setting Up an Application Load Balancer for an EC2 Instance

## 🎯 task:
The Nautilus DevOps team is currently working on setting up a simple application on the AWS cloud. They aim to establish an Application Load Balancer (ALB) in front of an EC2 instance where an Nginx server is currently running. While the Nginx server currently serves a sample page, the team plans to deploy the actual application later.

- Set up an Application Load Balancer named xfusion-alb.
- Create a target group named xfusion-tg.
- Create a security group named xfusion-sg to open port 80 for the public.
- Attach this security group to the ALB.
- The ALB should route traffic on port 80 to port 80 of the xfusion-ec2 instance.
- Make appropriate changes in the default security group attached to the EC2 instance if necessary.


## solution:
1. **Create a Security Group**:
   - Create a security group named xfusion-sg and allow inbound traffic on port 80 from anywhere (0.0.0.0/0).

2. **Create an Application Load Balancer**:
   - Create an Application Load Balancer named xfusion-alb in the same VPC and availability zone as the xfusion-ec2 instance.
   - Attach the xfusion-sg security group to the ALB.

3. **Create a Target Group**:
   - Create a target group named xfusion-tg with the appropriate settings (e.g., protocol HTTP, port 80).
   - Register the xfusion-ec2 instance as a target in the xfusion-tg target group.


4. **Configure ALB Listener**:
    - Set up a listener on the ALB to listen for HTTP traffic on port 80 and forward it to the xfusion-tg target group.

5. **Update EC2 Security Group**:

- If the default security group attached to the xfusion-ec2 instance does not allow inbound traffic on port 80, update it to allow traffic from the ALB's security group (xfusion-sg) on port 80.


6. **Test the Setup**:
   - Access the ALB's DNS name in a web browser to verify that it correctly routes traffic to the Nginx server running on the xfusion-ec2 instance, displaying the sample page.
### Troubleshooting: ALB Not Routing Traffic to EC2 Instance



## create required resources using AWS CLI:
```bash
# Create security group
aws ec2 create-security-group --group-name xfusion-sg --description "Security group for xfusion ALB"

# Allow inbound traffic on port 80 from anywhere
aws ec2 authorize-security-group-ingress --group-name xfusion-sg --protocol tcp --port 80 --cidr 0.0.0.0/0

# get VPC ID (replace <your-vpc-name> with the actual VPC name)
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=<your-vpc-name>" --query "Vpcs[0].VpcId" --output text

# Create target group
aws elbv2 create-target-group --name xfusion-tg --protocol HTTP --port 80 --vpc-id <your-vpc-id>

# Create Application Load Balancer
aws elbv2 create-load-balancer --name xfusion-alb --subnets <subnet-1> <subnet-2> --security-groups <xfusion-sg-id>

# Register EC2 instance with target group
aws elbv2 register-targets --target-group-arn <xfusion-tg-arn> --targets Id=<xfusion-ec2-instance-id>
# Create listener for ALB
aws elbv2 create-listener --load-balancer-arn <xfusion-alb-arn> --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=<xfusion-tg-arn>
```

