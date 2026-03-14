# Day 23: Automating User Data Configuration Using the CLI

## 🎯 task is to create a VM using Azure CLI with the following specifications:

- Instance Name: The VM must be named xfusion-vm.

- Image: Use any available Ubuntu image to create this VM.

- Custom Script Extension/User Data: Configure the VM to run a custom script during its launch. This script should:

`Install the Nginx package`
 `Start the Nginx service.`

Network Security Group (NSG): Ensure that the VM allows HTTP traffic on port 80 from the internet.

Instructions:

Use Azure CLI commands to set up the VM in the specified configuration.
Ensure the VM is accessible from the internet on port 80.
The Nginx service should be running after setup.

Use the Azure CLI commands to complete the task.

Notes:
Create the resources only in the East US region.
You may use the default resource group or create a new one if needed.


## Solution:
```bash
# custom script to install and start Nginx
cat <<EOF > cloud-init.txt
#cloud-config
packages:
  - nginx
runcmd:
  - systemctl start nginx
EOF

# verify resource group location (must be an approved region)
az group show --name kml_rg_main-16325101e65e4844 --query "{name:name,location:location}" -o table

# check if preferred VM sizes are available in eastus
az vm list-skus --location eastus --resource-type virtualMachines --all --query "[?restrictions==null && (name=='Standard_B1s' || name=='Standard_B2s' || name=='Standard_DS1_v2')].name" -o table

# create VM in eastus with policy-compliant OS disk settings
az vm create \
  --resource-group kml_rg_main-16325101e65e4844 \
  --name xfusion-vm \
  --location eastus \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --custom-data cloud-init.txt \
  --storage-sku Standard_LRS \
  --os-disk-size-gb 64

# if Standard_B1s has no capacity, retry with Standard_B2s
az vm create \
  --resource-group kml_rg_main-16325101e65e4844 \
  --name xfusion-vm \
  --location eastus \
  --image Ubuntu2204 \
  --size Standard_B2s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --custom-data cloud-init.txt \
  --storage-sku Standard_LRS \
  --os-disk-size-gb 64

# get the NSG ID attached to the VM NIC
az network nic show \
  --ids "$(az vm show --resource-group kml_rg_main-16325101e65e4844 --name xfusion-vm --query networkProfile.networkInterfaces[0].id -o tsv)" \
  --query networkSecurityGroup.id -o tsv

# add HTTP inbound rule on the attached NSG
az network nsg rule create \
  --ids "$(az network nic show --ids \"$(az vm show --resource-group kml_rg_main-16325101e65e4844 --name xfusion-vm --query networkProfile.networkInterfaces[0].id -o tsv)\" --query networkSecurityGroup.id -o tsv)" \
  --name AllowHTTP \
  --priority 1000 \
  --destination-port-ranges 80 \
  --protocol Tcp \
  --access Allow \
  --direction Inbound
```


## Verification:
1. After running the above commands, you can verify that the VM is created and running by using the following command:
```bash
az vm show --resource-group kml_rg_main-16325101e65e4844 --name xfusion-vm --show-details
```
2. To check if Nginx is installed and running, you can SSH into the VM:
```bash
az vm ssh --resource-group kml_rg_main-16325101e65e4844 --name xfusion-vm
```
Once logged in, you can check the status of Nginx:
```bash
systemctl status nginx
```
3. Finally, you can verify that the VM is accessible from the internet on port 80 by opening a web browser and navigating to the public IP address of the VM. You should see the default Nginx welcome page, confirming that Nginx is installed and running correctly.
```bash
az vm list-ip-addresses --resource-group kml_rg_main-16325101e65e4844 --name xfusion-vm
```


