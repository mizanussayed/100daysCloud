# Day 3: Create VM using Azure CLI
### task
1) Create a new Azure Virtual Machine named devops-vm using the Azure CLI.

2) Use the Ubuntu2204 image and set the VM size to Standard_B2s.

3) Make sure the admin username is set to azureuser and SSH keys are generated for secure access.

4) Use Standard_LRS storage account, disk size must be 30GB and ensure the VM devops-vm is in the running state after creation. kml_rg_main-70ea101cdc604ee 

### Solution
1. Get current resource group name
```bash
az group list --output table
```
2. Create the VM using Azure CLI with the specified configurations

```bash
  az vm create \
  --resource-group myResourceGroup \
  --name devops-vm \
  --image Ubuntu2204 \
  --size Standard_B2s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --storage-sku Standard_LRS \
  --os-disk-size-gb 30 \
  --output json
```

3. Verify the VM is in the running state
```bash
az vm get-instance-view --resource-group myResourceGroup --name devops-vm --output table

# or
az vm get-instance-view -g myResourceGroup -n devops-vm -o table
```

## learn more
--> SSH into the VM using the generated SSH keys
```bash
ssh azureuser@<public-ip-address>
```
