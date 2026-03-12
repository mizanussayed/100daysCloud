# Day 21: Setting Up an EC2 Instance with an Elastic IP for Application Hosting

## 🎯 The Nautilus DevOps Team has received a new request from the Development Team to set up a new EC2 instance. This instance will be used to host a new application that requires a stable IP address. To ensure that the instance has a consistent public IP, an Elastic IP address needs to be associated with it. The instance will be named xfusion-ec2, and the Elastic IP will be named xfusion-eip. This setup will help the Development Team to have a reliable and consistent access point for their application.

Create an EC2 instance named xfusion-ec2 using any linux AMI like ubuntu, the Instance type must be t2.micro and associate an Elastic IP address with this instance, name it as xfusion-eip.

```bash
# Step 1: Create an EC2 instance
aws ec2 run-instances --image-id ami-0abcdef1234567890 --count 1 --instance-type t2.micro --key-name your-key-pair --security-group-ids sg-0123456789abcdef0 --subnet-id subnet-0123456789abcdef0
# Step 2: Allocate an Elastic IP address
aws ec2 allocate-address --domain vpc
# Step 3: Associate the Elastic IP address with the EC2 instance
aws ec2 associate-address --instance-id i-0123456789abcdef0 --allocation-id eipalloc-0123456789abcdef0
```

