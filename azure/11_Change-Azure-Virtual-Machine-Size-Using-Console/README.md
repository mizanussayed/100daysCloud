# Day 11: Change Azure Virtual Machine Size Using Console
1) Change the VM size from Standard_B1s to Standard_B2s for the virtual machine named datacenter-vm.

2) Ensure the VM is in the running state after the size change is complete.

Note:
Create the resources only in centralus region.
Make sure the VM is in the Running state after resizing.


## Solution:
```bash
# first, get the current size of the VM
az vm show --resource-group datacenter-rg --name datacenter-vm --query "hardwareProfile.vmSize" -o tsv
# stop the VM before resizing
az vm deallocate --resource-group datacenter-rg --name datacenter-vm
# resize the VM to Standard_B2s
az vm resize --resource-group datacenter-rg --name datacenter-vm --size Standard_B2s
```

