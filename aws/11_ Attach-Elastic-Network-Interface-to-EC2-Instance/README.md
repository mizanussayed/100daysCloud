# Day 11: Attach Elastic Network Interface to EC2 Instance
### task:
- An instance named datacenter-ec2 and an elastic network interface named datacenter-eni already exists in us-east-1 region.
- Attach the datacenter-eni network interface to the datacenter-ec2 instance.
- Make sure status is attached before submitting the task.
- Please make sure instance initialisation has been completed before submitting this task.

### Solution:
1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
2. In the navigation pane, choose "Network Interfaces".
3. Select the network interface named "datacenter-eni" from the list of network interfaces.
4. In the details pane, choose "Actions", then "Attach".
5. In the "Attach Network Interface" dialog box, select the instance named "datacenter-ec2" from the "Instance" dropdown menu.
6. Click "Attach" to attach the network interface to the instance.