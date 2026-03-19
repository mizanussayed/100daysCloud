# Day 27: Deploying Virtual Machines in a Private Virtual Network

## 🎯 task:
-  The name of the VNet must be devops-priv-vnet, 
-  create a subnet named devops-priv-subnet under the same.
-  create a Virtual Machine named devops-priv-vm under this VNet.
-  create a Network Security Group (NSG) named devops-priv-nsg
-  ensure that the NSG rules for the VM allow access only from within the VNet's CIDR block. 
-  Ensure all resources are created in the Central US region.

## 🧑‍💻 solution: 
1. **Create a Virtual Network (VNet)**:
   - Go to the Azure Portal.
   - Click on "Create a resource" and search for "Virtual Network".
   - Click "Create".
   - Name it `devops-priv-vnet`.
   - Select the Central US region.
   - Set the IPv4 address space (e.g., `10.0.0.0/16`).
   - Click "Create".


2. **Create a Subnet**:
   - After the VNet is created, go to the VNet resource.
    - Click on "Subnets" under the Settings section.
   - Click "Add subnet".
    - Name it `devops-priv-subnet`.
    - Set the subnet address range (e.g., `10.0.1.0/24`).
    - Click "Create".

3. **Create a Network Security Group (NSG)**:
   - Go to the Azure Portal.
   - Click on "Create a resource" and search for "Network Security Group".
   - Click "Create".
   - Name it `devops-priv-nsg`.
   - Select the Central US region.
   - Click "Create".

4. **Configure NSG Rules**:
   - After the NSG is created, go to the NSG resource.
   - Click on "Inbound security rules" under the Settings section.
   - Click "Add".
   - Set the following:
     - Source: IP Addresses
     - Source IP addresses/CIDR ranges: `10.0.0.0/16`
     - Destination: Any
     - Destination port ranges: `22`
     - Protocol: TCP
     - Priority: `1000`
     - Action: `Allow`
   - Click "Create".


5. **Create a Virtual Machine**:
   - Go to the Azure Portal.
   - Click on "Create a resource" and search for "Virtual Machine".
   - Click "Create".
   - Name it `devops-priv-vm`.
   - Select the Central US region.
   - Choose an appropriate image (e.g., Ubuntu Server).
   - Choose a size (e.g., Standard B1s).
   - Under "Networking", select the `devops-priv-vnet` and `devops-priv-subnet`.
   - Under "Network security group", select "Use existing" and choose `devops-priv-nsg`.
   - Click "Review + create" and then "Create".


## cli:
```bash
# Create a resource group
az group create --name devops-priv-rg --location centralus
# Create a virtual network
az network vnet create --resource-group devops-priv-rg --name devops-priv-vnet --address-prefixes

# Create a subnet
az network vnet subnet create --resource-group devops-priv-rg --vnet-name devops-priv-vnet --name devops-priv-subnet --address-prefixes

# Create a network security group
az network nsg create --resource-group devops-priv-rg --name devops-priv-nsg --location centralus

# Create an NSG rule to allow SSH access from within the VNet
az network nsg rule create --resource-group devops-priv-rg --nsg-name devops-priv-nsg --name AllowSSHFromVNet --priority 1000 --source-address-prefixes

az network nsg rule create --resource-group devops-priv-rg --nsg-name devops-priv-nsg --name AllowSSHFromVNet --priority 1000 --source-address-prefixes

# Create a virtual machine
az vm create --resource-group devops-priv-rg --name devops-priv-vm --image Ubuntu2204 --size Standard_B1s --vnet-name devops-priv-vnet --subnet devops-priv-subnet --nsg devops-priv-nsg --admin-username azureuser --generate-ssh-keys
```
