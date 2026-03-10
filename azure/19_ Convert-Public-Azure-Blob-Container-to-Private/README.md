# Day 19: Convert Public Azure Blob Container to Private

## 🎯 Task

Two blob containers named `devops-container-25941` and `devops-priv-17476` are available in the centralus region within the storage account `devopsst5088`. The `devops-container-25941` is currently public, and `devops-priv-17476` is private.

1) Convert the blob container `devops-container-25941` from public to private while leaving `devops-priv-17476` unchanged.

2) Make sure the access level for `devops-container-25941` is set to private with no public access.

## 🧑‍💻 Solution:
Prerequisite (Azure AD authentication):

```bash
az login
```

## First to check the access level of the blob container `devops-container-25941` and `devops-priv-17476` using Azure CLI:

```bash
az storage container show --name devops-container-25941 --account-name devopsst5088 --query "publicAccess" --auth-mode login
az storage container show --name devops-priv-17476 --account-name devopsst5088 --query "publicAccess" --auth-mode login
```

## Then to set the access level of the blob container `devops-container-25941` to private using Azure CLI:
```bash
az storage container set-permission --name devops-container-25941 --account-name devopsst5088 --public-access off --auth-mode login
```
## Finally, to verify that the access level of the blob container `devops-container-25941` has been successfully changed to private:
```bash
az storage container show --name devops-container-25941 --account-name devopsst5088 --query "publicAccess" --auth-mode login
```


