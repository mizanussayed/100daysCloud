# Day 46: EventHub to Blob Storage Integration Setup

## 🎯 Objective
The Nautilus DevOps team wants to integrate an Azure Virtual Machine with Azure Event Hubs and Azure Blob Storage for centralized log collection and backup. Follow these steps to complete the task:

1. Create Azure Event Hubs Namespace:

2. Create an Event Hubs namespace named devops-namespace in the East US region.
    - Select the Standard pricing tier. Make sure to enable Enable Auto-inflate.
    - Create an Event Hub:
    - Within the namespace, create an Event Hub named devops-hub.

3. Set Up Azure Blob Storage for Log Backup:
    - Create a Storage Account named devopsst6452 in the East US region.
    - Create a container named devops-backup-14959 within the Storage Account.
    - Ensure the container is publicly accessible for read operations.

4. Verify the Virtual Machine Configuration:
    - The client host already has a Python script named send_logs.py located under /root. This script is used to send logs to the Event Hub.
    - Create a Virtual Machine named devops-vm in the East US region.
    - Copy the send_logs.py script from the client host to the /home/azureuser directory of the devops-vm.
    - Modify the script on the VM to also back up the logs to the devops-backup-14959 container in the Azure Blob Storage account.

5. Verify Logs:
    - Ensure the logs are successfully sent to the Event Hub by checking the Event Hubs metrics in the Azure portal.
    - Verify that the logs are backed up to the devops-backup-14959 container in the Azure Blob Storage.

## Troubleshooting
```bash
 python3 send_logs.py 
Traceback (most recent call last):
  File "/home/azureuser/send_logs.py", line 2, in <module>
    from azure.storage.blob import BlobServiceClient
ModuleNotFoundError: No module named 'azure'
```

### Solution:
```bash
sudo apt update
sudo apt install python3-pip -y
sudo apt install python3-venv -y
python3 -m venv venv
source venv/bin/activate
pip install azure-storage-blob azure-eventhub
```

## Video Walkthrough
[![EventHub to Blob Storage Integration Setup](https://img.youtube.com/vi/00h0QGGso1s/0.jpg)](https://youtu.be/5PPgpSqW1vM)
