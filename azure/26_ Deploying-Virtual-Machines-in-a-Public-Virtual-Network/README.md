# Day 26: Deploying Virtual Machines in a Public Virtual Network

## 🎯 Objective
- Create a public VNet named devops-pub-vnet, and a subnet named devops-pub-subnet under the same, 
- make sure public IP is being auto-assigned to resources under this subnet. 
- create a VM named-devops-pub-vm under this VNet. 
- Make sure SSH port 22 is open for this instance and accessible over the internet.
- Use the Azure portal to complete the task and ensure that SSH access is configured correctly.


## Solution:
```bash
# create resource group
az group create \
  --name <group-name> \
  --location eastus

# create public VNet and subnet with auto-assign public IP enabled
az network vnet create \
  --resource-group <group-name> \
  --name devops-pub-vnet \
  --address-prefixes 10.0.0.0/16

# create security group for SSH access
az network nsg create \
  --resource-group <group-name> \
  --name devops-pub-nsg

# allow inbound SSH (port 22) from internet
az network nsg rule create \
  --resource-group <group-name> \
  --nsg-name devops-pub-nsg \
  --name Allow-SSH \
  --protocol tcp \
  --priority 1000 \
  --destination-port-range 22 \
  --access allow \
  --direction inbound \
  --source-address-prefixes '*' \
  --destination-address-prefixes '*'


# create subnet with NSG and auto-assign public IP enabled
az network vnet subnet create \
    --resource-group <group-name> \
    --vnet-name devops-pub-vnet \
    --name devops-pub-subnet \
    --address-prefixes 10.0.1.0/24 \
    --network-security-group devops-pub-nsg


# create vm in the public subnet
az vm create \
  --resource-group <group-name> \
  --name devops-pub-vm \
  --location eastus \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --storage-sku Standard_LRS \
  --os-disk-size-gb 30 \
  --vnet-name devops-pub-vnet \
  --subnet devops-pub-subnet \
  --public-ip-address-allocation dynamic
```