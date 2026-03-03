# Day 12: Add and Manage Tags for Azure Virtual Machines

## task 
-  The team has identified one VM that is not tagged properly so they decided to tag it as needed.
- Add the tag Environment=dev to the virtual machine named xfusion-vm. 


## Solution
1. In the Azure portal, navigate to the virtual machine named xfusion-vm.
2. In the left-hand menu, click on "Tags" under the "Settings" section.
3. Click on the "Add" button to add a new tag.
4. In the "Name" field, enter "Environment".
5. In the "Value" field, enter "dev".
6. Click on the "Save" button to save the tag.

## Command Line 
```bash
az vm update --resource-group <resource-group-name> --name xfusion-vm --set tags.Environment=dev
```
