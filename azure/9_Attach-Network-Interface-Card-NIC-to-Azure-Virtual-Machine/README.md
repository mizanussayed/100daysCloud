# Day 9: Attach Network Interface Card (NIC) to Azure Virtual Machine

### task: 
- An existing VM named devops-vm and a network interface named devops-nic already exist in the southcentralus region.
- Attach the network interface devops-nic to the VM devops-vm.
- Ensure the NIC's status is attached before submitting the task.
- Make sure that the virtual machine initialization has been completed before submitting this task.


### Solution:
1. Open the Azure portal and navigate to the "Virtual machines" section.
2. Select the virtual machine named "devops-vm" from the list.
3. In the virtual machine's overview page, click on "Networking" in the left-hand menu.
4. Click on the "Attach network interface" button at the top of the page.
5. In the "Attach network interface" pane, select the existing network interface named "devops-nic" from the dropdown menu.
6. Click on the "OK" button to attach the network interface to the virtual machine.
7. Wait for the attachment process to complete and ensure that the status of the network interface is shown as "Attached" in the virtual machine's networking section.
8. Finally, verify that the virtual machine initialization has been completed by checking the "Boot diagnostics" or "Serial console" for any errors or issues during the boot process.


```bash
## get resource group name
RESOURCE_GROUP=$(az vm list --query "[?name=='devops-vm'].resourceGroup | [0]" -o tsv)
VM_NAME="devops-vm"
NIC_NAME="devops-nic"

# VM must be stopped/deallocated before adding a NIC
az vm deallocate --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"

# Azure CLI command to attach the network interface to the virtual machine
az vm nic add --resource-group "$RESOURCE_GROUP" --vm-name "$VM_NAME" --nics "$NIC_NAME"

# Start the VM again
az vm start --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"

# Verify NIC is attached
az vm nic list --resource-group "$RESOURCE_GROUP" --vm-name "$VM_NAME" --query "[].id" -o tsv
```