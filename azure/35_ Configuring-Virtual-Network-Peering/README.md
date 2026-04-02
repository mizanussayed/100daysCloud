# Day 35: Configuring Virtual Network Peering

## 🎯
The Nautilus DevOps team has been tasked with demonstrating the use of VNet Peering to enable communication between two VNets. One VNet will be a private VNet that contains a private Azure VM, while the other will be a public VNet containing a publicly accessible Azure VM.

1) Existing Azure Resources:

Public VM: devops-pub-vm is already in the public VNet.
Private VNet and VM: devops-priv-vnet and devops-priv-vm exist in the private VNet with its subnet: devops-priv-subnet.
2) Create VNet Peering:

Create a VNet Peering between the Public VNet and Private VNet.
VNet Peering Name: devops-pub-to-priv-peering.
3) Test the Connection:

SSH into the public VM and verify that you can ping the private VM.

## Solutions:
1. **Create VNet Peering**:
- Go to the Azure Portal and navigate to the "Virtual Networks" section.
- Select the public VNet that contains the devops-pub-vm.
- In the left-hand menu, click on "Peerings" and then click "Add".
- Fill in the peering details:
- Name: devops-pub-to-priv-peering
- Select the private VNet (devops-priv-vnet) as the peering target
- Configure the peering settings as needed (e.g., allow virtual network access, allow forwarded traffic, etc.)
- Click "Create" to establish the peering connection.

2. **Test the Connection**:
- SSH into the public VM (devops-pub-vm) using its public IP address
- Once logged in, use the ping command to test connectivity to the private VM (devops-priv-vm) using its private IP address:
```bash
ping <private-ip-of-devops-priv-vm>
```
- If the ping is successful, it indicates that the VNet peering is correctly configured and the public VM can communicate with the private VM.

