# Day 36: Managing Storage Lifecycle in Azure

## 🎯 Objective

The Nautilus DevOps team needs to optimize data retention costs by automating the deletion of old blobs. They plan to implement Blob Lifecycle Management for a specific container in Azure Storage.

Task:
1) Create a Storage Account:

Name the storage account devopsstor21010.
Set the region to East US.
Use Locally-redundant storage (LRS) as the redundancy option.
2) Create a Blob Container:

Name the container devops-container21010.
3) Upload a File to the Container:

Upload the file named tempfile.txt to the container. The file is present under /root of the client host.
4) Configure Blob Lifecycle Management:

Apply a Lifecycle Management rule named devops-del-rule to the container devops-container21010 to delete blobs after 7 days of last modification.
5) Validation:

Verify that the Lifecycle Management rule named devops-del-rule is correctly applied.


upload a file to Azure Blob Storage, set up lifecycle management policies to automatically transition the blob to a cooler storage tier after a specified period, and verify that the lifecycle management policies are working as expected.
```bash
az storage blob upload --account-name devopsstor21010 --container-name devops-container21010 --name tempfile.txt --file /root/tempfile.txt
```