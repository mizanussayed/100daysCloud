# Day 42: Backup and Delete Azure Storage Blob Container

## 🎯 Objective
The Nautilus DevOps team is currently engaged in a cleanup process, focusing on removing unnecessary data and services from their Azure environment. As part of the migration process, several resources were created for one-time use only, necessitating a cleanup effort to optimize their Azure environment.

A private blob container named devops-blob-5952 already exists in the centralus region under storage account devopsst24252.

1) Copy the contents of devops-blob-5952 blob container to the /opt directory on the azure-client host (the landing host once you load this lab).

2) Delete the blob container devops-blob-5952 from the storage account.

```bash
az storage blob download-batch -d . --account-name devopsst24252 -s devops-blob-5952
```

## Video Demonstration
[![Working with Azure Table Storage](https://img.youtube.com/vi/00h0QGGso1s/0.jpg)](https://www.youtube.com/watch?v=JtJzUPPL3uw)