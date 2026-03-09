# Day 18: Copy Data to an Azure Blob Storage Container

- A Blob container named datacenter-blob-19611 already exists in the eastus region under the storage account datacenterst25292. 
- Copy the file /tmp/datacenter.txt to the Blob container datacenter-blob-19611.


## Solution
1. Use the `az storage blob upload` command to copy the file to the Blob container.

```bash
# get the storage account list
az storage account list --query "[?name=='datacenterst25292']"

# get container list
az storage container list \
  --account-name datacenterst25292 \
  --query "[?name=='datacenter-blob-19611']"

# upload
az storage blob upload \
  --account-name datacenterst25292 \
  --container-name datacenter-blob-19611 \
  --name datacenter.txt \
  --file /tmp/datacenter.txt


# Verify the upload
az storage blob list \
  --account-name datacenterst25292 \
    --container-name datacenter-blob-19611 \
    --query "[?name=='datacenter.txt']"
```

