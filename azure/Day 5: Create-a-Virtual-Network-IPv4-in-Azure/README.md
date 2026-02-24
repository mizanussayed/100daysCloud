# Day 5: Create a Virtual Network (IPv4) in Azure

### task:
Create a Virtual Network (VNet) named devops-vnet in the eastus region with 192.168.0.0/24 IPv4 CIDR.

### solution:
1. Log in to the Azure portal.
2. Click on "Create a resource" and search for "Virtual Network".
3. Click on "Virtual Network" and then click "Create".
4. Fill in the required details:
   - Subscription: Select your subscription.
   - Resource group: Create a new resource group or select an existing one.
   - Name: devops-vnet
   - Region: East US
5. Under "IP Addresses", set the IPv4 CIDR block to 192.168.0.0/24.


```bash
# Azure CLI command to create the virtual network
az network vnet create \
  --name devops-vnet \
  --resource-group <your-resource-group> \
  --location eastus \
  --address-prefixes 192.168.0.0/24
```