## Day 17: Create a Public Azure Blob Storage Container
- Create a new storage account named xfusionst13765 and a public Blob container named xfusion-blob-10445 within the storage account. 
- Make sure anonymous read access for containers and blobs is enabled.




## by azure client
```bash
az storage account create --name xfusionst13765  --resource-group <YourResourceGroup> --location eastus --sku Standard_LRS --kind StorageV2

## set public access level to container
az storage container create --name xfusion-blob-10445  --account-name xfusionst13765 --public-access container

## verify
az storage container show --name xfusion-blob-10445 --account-name xfusionst13765
```
