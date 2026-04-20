# Day 49: VM Setup with Web Storage Integration

## 🎯Task Details:
1) Create a Virtual Network (VNet) and Subnet:

    - Create a VNet named xfusion-vnet in the East US region.
    - Create a subnet named xfusion-subnet within the VNet for the VM.
2) Create an Azure Storage Account:

    - Create a storage account named xfusionstor6389 in the East US region with Locally-redundant storage (LRS).
    - Create a Blob container named xfusion-container in the storage account.
    - Upload the index.html file located at /root on the client host to the container xfusion-container.
    - Ensure the Storage Account is private and not publicly accessible by disabling public access for the storage account.
3) Create a Virtual Machine (VM):

    - Create a VM named xfusion-vm in the East US region.

    - Use the xfusion-vnet and subnet xfusion-subnet for the VM.

    - Authentication: Use SSH public key authentication. (Please select use existing public key option, create public-key locally and paste contents of ~/.ssh/id_rsa.pub)

    - Install Nginx on the VM.

    - Download the index.html file using a command such as:

    ```bash
    sudo az storage blob download --account-name xfusionstor6389 --account-key xxxxx --container-name xfusion-container --name index.html --file /var/www/html/index.html
    ```

    - Ensure Nginx is configured to serve the file from /var/www/html/index.html.

4) Verify Setup:

    - Verify that the Nginx web server on the client host serves the index.html file correctly when accessing the VM's public IP address. 


```bash
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

sudo az storage blob download --account-name xfusionstor6389 --account-key xxx --container-name xfusion-container --name index.html --file /var/www/html/index.html
```
## Video Walkthrough:
[![VM Setup with Web Storage Integration](https://img.youtube.com/vi/_nDJ1G0s6Ls/0.jpg)](https://youtu.be/_nDJ1G0s6Ls)



