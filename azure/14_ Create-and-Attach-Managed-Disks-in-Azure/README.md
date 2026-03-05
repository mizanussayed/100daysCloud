# Day 14: Create and Attach Managed Disks in Azure

## task:
Create a managed disk with the following requirements:

Name of the disk should be xfusion-disk.

Disk type must be Standard_LRS.

Disk size must be 2 GiB.


## Solution:
1. Go to the Azure portal and navigate to the "Disks" service.
2. Click on the "Create" button to create a new managed disk.
3. Fill in the required details:
    - Name: xfusion-disk
    - Resource Group: Select an existing resource group or create a new one.
    - Location: Choose the desired location for the disk.
    - Source type: None (empty disk)
    - Size: 2 GiB
    - Performance tier: Standard_LRS
4. Click on the "Review + create" button to review the details and then click on the "Create" button to create the managed disk.


## by command line:
You can also create a managed disk using the Azure CLI with the following command:

```bash
az disk create \
  --resource-group <your-resource-group> \
  --name xfusion-disk \
  --size-gb 2 \
  --sku Standard_LRS
```

Replace `<your-resource-group>` with the name of your resource group. This command will create a managed


