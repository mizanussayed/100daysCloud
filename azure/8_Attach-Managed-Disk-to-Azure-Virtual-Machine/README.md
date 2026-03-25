# Day 8: Attach Managed Disk to Azure Virtual Machine


### taske 
- attaching an existing data disk to a virtual machine (VM).
- An existing VM named nautilus-vm and a managed disk named nautilus-disk already exist in the westus region.
- Attach the disk nautilus-disk to the VM nautilus-vm as a data disk.


### solution:
1. Go to Azure Portal, navigate to the VM nautilus-vm, click Disks under Settings, and click + Add data disk.
2. Click Create disk, fill in the form as below, and click Review + create.
    - Subscription: your subscription
    - Resource group: xfusion-rg
    - Name: nautilus-disk
    - Region: westus
    - Source type: None (empty disk)
    - Size: 128 GiB
3. After the disk is created, select it in the drop-down list of the data disk, and click Save to attach the disk to the VM.

### By Command Line Interface (CLI):
```bash
az vm disk attach \
  --resource-group xfusion-rg \
  --vm-name nautilus-vm \
  --name nautilus-disk
```

