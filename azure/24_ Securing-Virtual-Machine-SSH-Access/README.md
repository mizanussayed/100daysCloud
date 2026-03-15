# Day 24: Securing Virtual Machine SSH Access

## 🎯 task:
The Nautilus DevOps team needs to set up a new Virtual Machine (VM) on the Azure cloud that can be accessed securely from their landing host (azure-client). Follow the steps below to complete this task:

- Create an SSH Key: On the azure-client host, check if an SSH key already exists. If it doesn’t exist, create a new SSH key on the azure-client host that will be used for password-less SSH access.

- Create a Virtual Machine: Use the Azure Portal or Azure CLI to create a new Virtual Machine named xfusion-vm in the westus region. Set the VM size to Standard_B1s and configure the VM with SSH access for the azureuser account using the newly created SSH key.

- Configure SSH Access: Ensure that the SSH key from the azure-client host is added to the azureuser account on xfusion-vm, enabling secure, password-less SSH access from the azure-client host.

- Verify Connectivity: Test the connection from azure-client to xfusion-vm using SSH to confirm that password-less access has been set up correctly.

- Complete these tasks entirely within the Azure Portal or Azure CLI.

## solution:
1. **Create an SSH Key**:
   - On the azure-client host, open a terminal and check for existing SSH keys:
```bash
ls ~/.ssh/id_rsa.pub
```
- If the key does not exist, create a new SSH key:

```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
```

## create vm using azure cli:
```bash
az vm create \
--resource-group kml_rg_main-68aa08644b744bc8 \
--name xfusion-vm \
--image Ubuntu2204 \
--size Standard_B1s \
--admin-username azureuser \
--generate-ssh-keys \
--storage-sku Standard_LRS \
--os-disk-size-gb 30 \
--ssh-key-values ~/.ssh/id_rsa.pub \
--location westus
```

### Resources created by `az vm create`:
| Name | Type |
|---|---|
| xfusion-vm | Virtual machine |
| xfusion-vmNSG | Network security group |
| xfusion-vmPublicIP | Public IP address |
| xfusion-vmVMNic | Network interface |
| xfusion-vmVNET | Virtual network |

### Troubleshooting: `PropertyChangeNotAllowed` on `osDisk.managedDisk.storageAccountType`
This error occurs when a previous failed deployment left behind an OS disk with a different storage type. Azure does not allow changing the storage type of an existing managed disk.

**Fix — specify a new OS disk name to avoid the conflict:**
```bash
az vm create \
  --resource-group kml_rg_main-68aa08644b744bc8 \
  --name xfusion-vm \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --storage-sku Standard_LRS \
  --os-disk-size-gb 30 \
  --os-disk-name xfusion-vm-osdisk \
  --ssh-key-values ~/.ssh/id_rsa.pub \
  --location westus
```

Alternatively, delete the orphaned disk first and re-run the original command:
```bash
# Find and delete the leftover disk
az disk list --resource-group kml_rg_main-68aa08644b744bc8 \
  --query "[?contains(name,'xfusion-vm')].name" -o tsv

az disk delete --resource-group kml_rg_main-68aa08644b744bc8 \
  --name <disk-name> --yes
```

4. **Verify Connectivity**:
- From the azure-client host, use the following command to test SSH connectivity to xfusion-vm:

```bash
ssh azureuser@<xfusion-vm-ip-address>
```





