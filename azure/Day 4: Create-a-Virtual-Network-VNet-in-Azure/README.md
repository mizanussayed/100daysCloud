# Day 4: Create a Virtual Network (VNet) in Azure

## Task:
Create a Virtual Network (VNet) named nautilus-vnet in the southcentralus region with any IPv4 CIDR block.

## Steps:
1. Log in to the Azure portal at https://portal.azure.com.
2. In the search bar, type "Virtual Network" and select it from the list of results.
3. Click on the "Create" button to start the VNet creation process.
4. Fill in the required fields:
   - Subscription: Select your Azure subscription.
   - Resource group: Create a new resource group or select an existing one.
   - Name: Enter "nautilus-vnet" as the name of your VNet.
   - Region: Select "South Central US" from the dropdown menu.
6. Under the "IP Addresses" section, click on "Add subnet" to create a subnet for your VNet.
7. Fill in the subnet details:
   - Subnet name: Enter a name for your subnet (e.g., "nautilus-subnet").
   - Subnet address range: Enter an IPv4 CIDR block (e.g., "10.0.1.0/24").
8. Click "Add" to create the subnet.
9. Review the settings and click "Create" to deploy the VNet.

## by command line:
You can also create a VNet using the Azure CLI with the following command:
```bash
az network vnet create \
  --name nautilus-vnet \
  --resource-group <your-resource-group> \
  --location southcentralus \
  --address-prefixes 10.0.0.0/16


## get list of vnets
az network vnet list --resource-group <your-resource-group> --output table