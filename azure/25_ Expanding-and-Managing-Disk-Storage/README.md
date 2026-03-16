# Day 25: Expanding and Managing Disk Storage

## 🎯 The Nautilus DevOps team needs to expand the storage capacity of an existing virtual machine and add an additional data disk to support increased workloads. This task requires resizing the existing VM disk and mounting a new data disk to the VM.

As a member of the team, perform the following steps:

1) Expand the existing VM devops-vm disk from 32Gi to 64Gi.

2) Also create a new standard HDD data disk named devops-disk of 64Gi and mount the disk to VM devops-vm at location /mnt/devops-disk.

### Step 1: Expand the existing VM disk
To expand the existing VM disk, follow these steps:
1. Go to the Azure portal and navigate to the "Virtual Machines" section.
2. Select the VM named "devops-vm".
3. In the VM settings, click on "Disks" under the "Settings" section.
4. Select the OS disk (usually named something like "devops-vm_OSDisk").
5. Click on "Size + performance" and select the new size (64Gi).

### Step 2: Create and mount a new data disk
To create and mount a new data disk, follow these steps:
1. In the Azure portal, navigate to the "Disks" section.
2. Click on "Add" to create a new disk.
3. Fill in the details for the new disk:
    - Name: devops-disk
    - Resource group: Select the same resource group as the VM
    - Size: 64Gi
    - Performance: Standard HDD
4. Click "Review + create" and then "Create" to provision the new disk.
5. Once the disk is created, go back to the "Virtual Machines" section and select "devops-vm".
6. In the VM settings, click on "Disks" and then click on "Add data disk".
7. Select the newly created disk "devops-disk".

## by command line interface (CLI):
1. To expand the existing VM disk, use the following command:
```bash
# get os disk name
az vm show --resource-group <ResourceGroupName> --name devops-vm --query "storageProfile.osDisk.name" -o tsv

# deallocate the VM before resizing the OS disk
az vm deallocate --resource-group <ResourceGroupName> --name devops-vm

az disk update --resource-group <ResourceGroupName> --name <OSDiskName> --size-gb 64

# start the VM after resizing
az vm start --resource-group <ResourceGroupName> --name devops-vm
```

1. SSH into the VM and expand the OS partition/filesystem:
```bash
ssh <username>@<VM-Public-IP>

# install growpart if not already installed
sudo apt-get update
sudo apt-get install -y cloud-guest-utils

# detect root disk and partition (example output: /dev/sdb and partition 1)
lsblk

# example for root on /dev/sdb1
sudo growpart /dev/sdb 1
sudo resize2fs /dev/sdb1

# verify root filesystem size increased
df -h /
```

1. To create a new data disk, use the following command:
```bash
az disk create --resource-group <ResourceGroupName> --name devops-disk --size-gb 64 --sku Standard_LRS
```

1. To mount the new data disk to the VM, use the following command:
```bash
az vm disk attach --resource-group <ResourceGroupName> --vm-name devops-vm --name devops-disk --lun 1
```

1. SSH into the VM and format and mount the disk:
```bash
# SSH into the VM
ssh <username>@<VM-Public-IP>

# Identify the new unpartitioned 64G disk (typically /dev/sdc or /dev/sdd)
lsblk

# Create a GPT partition and one primary partition
sudo parted -s /dev/<DataDisk> mklabel gpt
sudo parted -s /dev/<DataDisk> mkpart primary ext4 0% 100%

# Format the partition with ext4 filesystem
sudo mkfs.ext4 /dev/<DataDisk>1

# Create the mount point
sudo mkdir -p /mnt/devops-disk

# Mount the partition
sudo mount /dev/<DataDisk>1 /mnt/devops-disk

# Make the mount persistent across reboots using UUID
UUID=$(sudo blkid -s UUID -o value /dev/<DataDisk>1)
echo "UUID=$UUID /mnt/devops-disk ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
sudo mount -a

# Verify the mount
df -h /mnt/devops-disk
```
