# Day 36: Load Balancing EC2 Instances with Application Load Balancer

## 🎯 Objective
The Nautilus Development Team needs to set up a new EC2 instance and configure it to run a web server. This EC2 instance should be part of an Application Load Balancer (ALB) setup to ensure high availability and better traffic management. The task involves creating an EC2 instance, setting up an ALB, configuring a target group, and ensuring the web server is accessible via the ALB DNS.

Create a security group: Create a security group named devops-sg to open port 80 for the default security group (which will be attached to the ALB). Attach devops-sg security group to the EC2 instance.

Create an EC2 instance: Create an EC2 instance named devops-ec2. Use any available Ubuntu AMI to create this instance. Configure the instance to run a user data script during its launch.

This script should:

Install the Nginx package.
Start the Nginx service.
Set up an Application Load Balancer: Set up an Application Load Balancer named devops-alb. Attach default security group to the same.

Create a target group: Create a target group named devops-tg.

Route traffic: The ALB should route traffic on port 80 to port 80 of the devops-ec2 instance.

Security group adjustments: Make appropriate changes in the default security group attached to the ALB if necessary. Eventually, the Nginx server running under devops-ec2 instance must be accessible using the ALB DNS.

## Solutions:
1. **Create a Security Group**:
   - Click on "Security Groups" in the left-hand menu.
   - Click "Create Security Group" and name it `devops-sg`.
   - Add an inbound rule to allow HTTP traffic on port 80 from anywhere (0.0.0.0/0).

2. **Create an EC2 Instance**:
    - Choose an Ubuntu AMI (e.g., Ubuntu Server 20.04 LTS).
    - Select an instance type (e.g., t2.micro).
    - Configure the instance details as needed.
    - In the "Configure Security Group" step, select "Select an existing security group" and choose `devops-sg`.
    - In the "Configure Instance" step, add the following user data script to install and start Nginx:
      ```bash
      #!/bin/bash
      apt update -y
      apt install nginx -y
      systemctl start nginx
      systemctl enable nginx
        ```
    - Review and launch the instance. 

3. **Set Up an Application Load Balancer**:
    - In the EC2 Dashboard, click on "Load Balancers" in the left-hand menu.
    - Click "Create Load Balancer" and select "Application Load Balancer".
    - Name the load balancer `devops-alb`.
    - Choose the appropriate scheme (internet-facing) and IP address type (IPv4).
    - Configure the listeners to listen on port 80.
    - In the "Configure Security Settings" step, select the default security group.
    - In the "Configure Routing" step, create a new target group named `devops-tg` with the target type set to "Instance" and protocol set to HTTP on port 80.
    - Register the `devops-ec2` instance with the target group.
    - Review and create the load balancer.  

4. **Access the Nginx Server**:
    - Once the load balancer is active, note down the DNS name of the ALB.
    - Open a web browser and navigate to the ALB DNS name (e.g., http://devops-alb-1234567890.us-west-2.elb.amazonaws.com).
    - You should see the default Nginx welcome page, confirming that the setup is successful and the Nginx server is accessible via the ALB.



