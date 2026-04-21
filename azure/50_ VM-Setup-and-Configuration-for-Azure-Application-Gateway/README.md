# Day 50: VM Setup and Configuration for Azure Application Gateway

## 🎯 Task:
1) Azure Virtual Network and Subnet:

- Create a Virtual Network (VNet) named datacenter-vnet in the East US region.
- Create a Subnet named datacenter-subnet within the VNet for the VMs.
- Create a Subnet named datacenter-apgw-subnet within the VNet for the Application Gateway.
2) Azure Virtual Machines:

- Create two VMs named datacenter-vm1 and datacenter-vm2 in the East US region.
- Install Nginx on both VMs.
- Configure index.html on VM1 to display "Welcome to KKE Labs:Version 1".
- Configure index.html on VM2 to display "Welcome to KKE Labs:Version 2".
3) Azure Application Gateway:

- Create an Application Gateway named datacenter-apgw in the East US region.
- Assign the datacenter-apgw-subnet to the Application Gateway.
- Create a frontend IP configuration named datacenter-apgw-ip.
- Add the VMs datacenter-vm1 and datacenter-vm2 to the backend pool.
- Configure a basic routing rule to distribute traffic between the VMs.
4) Validation:

- Verify that the Application Gateway distributes traffic to both VMs.
Ensure that accessing the Application Gateway URL displays either "Welcome to KKE Labs:Version 1" or "Welcome to KKE Labs:Version 2" depending on the load balancing.

## Video Walkthrough:
[![VM Setup and Configuration for Azure Application Gateway](https://img.youtube.com/vi/hoaZbcmXI0M/0.jpg)](https://youtu.be/hoaZbcmXI0M)