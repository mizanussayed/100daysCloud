# Day 16: Create a Private Azure Blob Storage Container

## task:
Create a new storage account named xfusionst27282 and a private Blob container named xfusion-blob-25535 within the storage account.

## steps:
1. Log in to the Azure portal at https://portal.azure.com.
2. Click on "Create a resource" in the left-hand menu.
3. In the "Search the Marketplace" box, type "Storage account" and select it from the search results.
4. Click on the "Create" button to start the storage account creation process.
5. Fill in the required fields:
   - Subscription: Select your Azure subscription.
   - Resource group: Select an existing resource group or create a new one.
   - Storage account name: Enter "xfusionst27282".
   - Region: Choose a region (e.g., East US).
   - Performance: Select "Standard".
   - Redundancy: Choose "Locally-redundant storage (LRS)".

6. Click on the "Review + create" button, review your settings, and then click
    on the "Create" button to create the storage account.

7. Once the storage account is created, navigate to it by clicking on "Go to resource".
8. In the storage account overview, click on "Containers" under the "Data storage" section.
9. Click on the "+ Container" button to create a new container.
10. Fill in the required fields:
    - Name: Enter "xfusion-blob-25535".
    - Public access level: Select "Private (no anonymous access)".
11. Click on the "Create" button to create the private Blob container.


## by cli:
```bash
## get resource group name
az group list --query "[].name" -o tsv

## create storage account
az storage account create --name xfusionst27282 --resource-group <your-resource-group-name> --location eastus --sku Standard_LRS
## create blob container
az storage container create --name xfusion-blob-25535 --account-name xfusionst27282 --public-access off
```

## verify
```bash
## list blob containers in the storage account
az storage container list --account-name xfusionst27282 --query "[].name" -o tsv
```
