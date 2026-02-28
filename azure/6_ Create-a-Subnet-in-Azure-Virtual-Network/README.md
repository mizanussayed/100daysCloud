# Day 6: Create a Subnet in Azure Virtual Network
### task:
create a Virtual Network (VNet) named xfusion-vnet and one subnet named xfusion-subnet within the VNet in the centralus region. Make sure the IPv4 address range is 10.0.0.0/16.

### Solution:
1) Go to the Azure portal and navigate to "Virtual networks".
2) Click on "Create" and fill in the required details:
   - Subscription: Select your subscription.
   - Resource group: Create a new resource group or select an existing one.
   - Name: Enter "xfusion-vnet".
   - Region: Select "Central US".
   - Address space: Enter "
    


## By command line:
1) Create a resource group:
```bash 
az group create --name xfusion-rg --location centralus
```
2) Create a virtual network with a subnet:
```bash
az network vnet create --resource-group xfusion-rg --name xfusion-vnet --address-prefixes 10.0.0.0/16
az network vnet subnet create --resource-group xfusion-rg --vnet-name xfusion-vnet --name xfusion-subnet --address-prefixes 10.0.1.0/24 
```

