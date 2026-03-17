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



## Solution:
```bash
az group list -o table
# create VM and configure Nginx using custom data
az vm create \
  --resource-group <group-name> \
  --name xfusion-vm \
  --location eastus \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --storage-sku Standard_LRS \
  --os-disk-size-gb 30 \
  --custom-data <(echo '#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx')

# open HTTP port 80
az vm open-port \
  --resource-group <group-name> \
  --name xfusion-vm \
  --port 80

# get public IP
az vm show -d \
  --resource-group <group-name> \
  --name xfusion-vm \
  --query publicIps \
  -o tsv

# test HTTP response
curl http://PUBLIC-IP
```


## Verification:
1. Verify the VM details and public IP:
```bash
az vm show -d --resource-group <group-name> --name xfusion-vm
```
2. Verify HTTP access from your local machine:
```bash
curl http://PUBLIC-IP
```
3. (Optional) Verify Nginx service inside the VM:
```bash
az vm run-command invoke --resource-group <group-name> --name xfusion-vm --command-id RunShellScript --scripts "systemctl is-active nginx"
```


