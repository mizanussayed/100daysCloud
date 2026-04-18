# Day 47: SQL Database Migration and Setup

## 🎯 Objective
Task 1: Create an Azure SQL Database
1. Create a publicly accessible Azure SQL Database instance with the following details:
    - Database Name: xfusion-sqldb.
    - Server Name: xfusion-server-12960.
    - Location: West US
    - Backup Storage Redundancy: Locally-redundant backup storage.
    - Hardware Configuration: Basic (For less demanding workloads).
    - Admin Username: xfusion-admin.
    - Admin Password: Set an appropriate password.
    - Database Size: Set to 2 GiB.
    - Keep all other configurations as default.

2. Ensure the database is in the Ready state.

Task 2: Create a Storage Account
1. Create a Storage Account named xfusionst13643.
2. Configure a Blob Container named xfusion-container-14547 within this storage account.

Task 3: Backup the Azure SQL Database

1. Take a backup of the Azure SQL Database instance xfusion-sqldb and store it in the Blob Container:
- Storage Account: xfusionst13643.
- Blob Container: xfusion-container-14547.
- Backup File Name: xfusion-db-backup.
- Ensure the backup is fully exported to the blob container.

Task 4: Download the Backup
1. Download the backup file from the Blob Container to the /opt directory on the azure-client host.
- Ensure the file is accessible and properly named based on its extension.

## Requirements for Completion
- Ensure the SQL Database is in the Ready state.
- Confirm the backup is stored in the specified Blob Container.
- Verify the backup file is successfully downloaded to the /opt directory on the client host.

```bash
 az storage blob download --account-name xfusionst13643 --account-key <ACCOUNT_KEY> --container-name xfusion-container-14547 --name xfusion-db-backup.bacpac --file /opt/xfusion-db-backup.bacpac
```



## az blob [download](https://learn.microsoft.com/en-us/cli/azure/storage/blob?view=azure-cli-latest#az-storage-blob-download)


## Video walkthrough
[![SQL Database Migration and Setup](https://img.youtube.com/vi/vAsw23bnWSI/0.jpg)](https://youtu.be/vAsw23bnWSI)

