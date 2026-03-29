# Day 32: Synchronizing Containers Using the CLI

## 🎯 Objective
As a member of the Nautilus DevOps Team, your task is to perform the following:

- Create a New Private Azure Blob Container: Name the container devops-dest-27490 under the storage account devopsst12248.

- Data Migration: Migrate the file devops.txt from the existing devops-source-12032 container to the new devops-dest-27490 container.

- Ensure Data Consistency: Ensure that both containers have the file devops.txt and confirm the file content is identical in both containers.

- Use Azure CLI: Use the Azure CLI to perform the creation and data migration tasks.

## 🛠️ Steps Performed
1. Created the new private Azure Blob Container.
2. Migrated the file devops.txt from the source container to the destination container.
3. Confirmed data consistency between both containers.

```bash
# Step 1: Create a new private Azure Blob Container
az storage container create --name devops-dest-27490 --account-name devopsst12248 --public-access off

# Step 2: Migrate the file devops.txt from the existing container to the new container
az storage blob copy start --source-uri "https://devopsst12248.blob.core.windows.net/devops-source-12032/devops.txt" --destination-container devops-dest-27490 --destination-blob devops.txt --account-name devopsst12248

# Step 3: Check the content of the file in both containers
# source container
az storage blob download --container-name devops-source-12032 --name devops.txt --account-name devopsst12248 --file devops_source.txt

# destination container
az storage blob download --container-name devops-dest-27490 --name devops.txt --account-name devopsst12248 --file devops_dest.txt
```
