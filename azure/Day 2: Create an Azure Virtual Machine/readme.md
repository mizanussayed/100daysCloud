# Creating an Azure Virtual Machine (VM).

The requirements are:

1) Use the existing resource group.

2) The VM name must be devops-vm, it should be in `central us` region.

3) Use the Ubuntu 24.04 LTS image for the VM.

4) The VM size must be Standard_B1s.

5) Attach a default Network Security Group (NSG) that allows inbound SSH (port 22).

6) Attach a 30 GB storage disk of type Standard HDD.

7) The rest of the configurations should remain as default.

After completing these steps, make sure you can SSH into the virtual machine

## Steps to Create an Azure Virtual Machine (VM)
1. **Log in to Azure Portal**: Go to the [Azure Portal](https://portal.azure.com/) and log in with your credentials.
2. **Navigate to Virtual Machines**: In the left-hand menu, click on "Virtual Machines" and then click on "Create" to start the VM creation process.
3. **Select Resource Group**: Choose the existing resource group where you want to create the VM.
4. **Configure Basic Settings**:
   - **Virtual Machine Name**: Enter `devops-vm`.
   - **Region**: Select `Central US`.
   - **Image**: Choose `Ubuntu 24.04 LTS`.
   - **Size**: Select `Standard_B1s`.
5. **Configure Networking**:
   - Ensure that a default Network Security Group (NSG) is attached.
   - In the NSG settings, allow inbound SSH traffic on port 22.
6. **Configure Disks**:
   - Attach a new disk with a size of 30 GB.
   - Select the disk type as `Standard HDD`.

7. **SSH into the VM**: Once the VM is created & deployed, you can SSH into it using the public IP address assigned to the VM. Use the following command in your terminal:
   ```bash
   ssh <username>@<public-ip-address>
   # by key
   ssh -i <path-to-private-key> <username>@<public-ip-address>
   # here -i  means identiy file
   ```
   

###  By command line, you can also use Azure CLI to create the VM with the specified configurations. Here is an example command:

```bash
  az vm create \
  --resource-group <your-resource-group> \
  --name devops-vm \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username <your-username> \
  --generate-ssh-keys \
  --nsg-rule SSH \
  --storage-sku Standard_LRS \
  --data-disk-sizes-gb 30
```
