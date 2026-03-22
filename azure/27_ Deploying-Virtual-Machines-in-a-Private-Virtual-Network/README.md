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
     - Destination: IP Addresses
     - Destination IP addresses/CIDR ranges: `10.0.0.0/16`
     - Destination port ranges: `22`
     - Protocol: Any
     - Priority: `100`
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


## using cli:
```bash
az network vnet create \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --name hhgj-priv-vnet \
  --location centralus \
  --address-prefix 10.0.0.0/16 \
  --subnet-name devops-priv-subnet \
  --subnet-prefix 10.0.1.0/24



  az network nsg create \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --name devops-priv-nsg \
  --location centralus

# Allow inbound access only from the VNet CIDR block
az network nsg rule create \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --nsg-name devops-priv-nsg \
  --name Allow-SSH-From-VNet-CIDR \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol "*" \
  --source-address-prefixes 10.0.0.0/16 \
  --source-port-ranges "*" \
  --destination-address-prefixes "10.0.0.0/16" \
  --destination-port-ranges "22"


az network nsg rule create \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --nsg-name devops-priv-nsg \
  --name Deny-All-Inbound \
  --priority 200 \
  --direction Inbound \
  --access Deny \
  --protocol "*" \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "10.0.0.0/16" \
  --destination-port-ranges "*"


az network vnet subnet update \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --vnet-name devops-priv-vnet \
  --name devops-priv-subnet \
  --network-security-group devops-priv-nsg

az vm create \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --name devops-priv-vm \
  --location centralus \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --vnet-name devops-priv-vnet \
  --subnet devops-priv-subnet \
  --nsg devops-priv-nsg \
  --public-ip-address "" \
  --admin-username azureuser \
  --generate-ssh-keys \
  --storage-sku Standard_LRS \
  --os-disk-size-gb 64


  az network nsg rule list \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --nsg-name devops-priv-nsg \
  --query "[].{name:name,priority:priority,src:sourceAddressPrefix,dstPort:destinationPortRange,access:access}" \
  -o table



  NIC_ID=$(az vm show \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --name devops-priv-vm \
  --query "networkProfile.networkInterfaces[0].id" -o tsv)



az network nic update \
  --ids $NIC_ID \
  --network-security-group devops-priv-nsg



az network nic show \
  --ids $NIC_ID \
  --query "networkSecurityGroup.id" -o tsv



az network nsg rule list \
  --resource-group kml_rg_main-25c7d6040fb4467f \
  --nsg-name devops-priv-nsg \
  --query "[].{name:name,priority:priority,src:sourceAddressPrefix,dstPort:destinationPortRange,access:access}" \
  -o table

  ```