#!/bin/bash

titles=(
"Create SSH Key Pair for Azure Virtual Machine"
"Create an Azure Virtual Machine"
"Create VM using Azure CLI"
"Create a Virtual Network (VNet) in Azure"
"Create a Virtual Network (IPv4) in Azure"
"Create a Subnet in Azure Virtual Network"
"Create a Public IP Address for Azure VM"
"Attach Managed Disk to Azure Virtual Machine"
"Attach Network Interface Card (NIC) to Azure Virtual Machine"
"Attach Public IP to Azure Virtual Machine"
"Change Azure Virtual Machine Size Using Console"
"Add and Manage Tags for Azure Virtual Machines"
"SSH into an Azure Virtual Machine"
"Create and Attach Managed Disks in Azure"
"Create and Configure Network Security Group (NSG) in Azure"
"Create a Private Azure Blob Storage Container"
"Create a Public Azure Blob Storage Container"
"Copy Data to an Azure Blob Storage Container"
"Convert Public Azure Blob Container to Private"
"Deploy Azure Resources Using ARM Template"
"Assigning Public IP to Virtual Machines"
"Configuring Instances with User Data"
"Automating User Data Configuration Using the CLI"
"Securing Virtual Machine SSH Access"
"Expanding and Managing Disk Storage"
"Deploying Virtual Machines in a Public Virtual Network"
"Deploying Virtual Machines in a Private Virtual Network"
"Troubleshooting Public Virtual Network Configurations"
"Working with Azure Container Registry (ACR)"
"Create Azure SQL Database"
"Deploying and Managing a Web Application"
"Synchronizing Containers Using the CLI"
"Integrating Virtual Machines with Application Load Balancer"
"Enabling Internet Connectivity for Virtual Machines"
"Configuring Virtual Network Peering"
"Managing Storage Lifecycle in Azure"
"Setting Up MySQL on a Virtual Machine in Azure"
"Running Containers on Azure Virtual Machines"
"Deploying a Static Website Using Containers on Azure"
"Managing Secrets with Azure Key Vault"
"Working with Azure Table Storage"
"Backup and Delete Azure Storage Blob Container"
"Configuring Azure VM with Application Gateway"
"Integrating Azure Event Hub with Virtual Machines"
"Azure Kubernetes Service (AKS) Setup and Management"
"EventHub to Blob Storage Integration Setup"
"SQL Database Migration and Setup"
"VM and ACR Integration for Storage"
"VM Setup with Web Storage Integration"
"VM Setup and Configuration for Azure Application Gateway"
)

for i in "${!titles[@]}"; do
    day=$((i+1))
    title="${titles[$i]}"

    folder="$(echo "$title" | tr ' ' '-' | tr -cd '[:alnum:]-')"

    mkdir -p "$folder"

    cat <<EOF > "$folder/README.md"
# Day ${day}: ${title}

## 🎯 Objective
Describe what you aim to achieve in this lab.

## 🛠 Steps Performed
1.
2.
3.

## 💻 Commands Used
\`\`\`bash

\`\`\`

## 📘 Notes
Add important observations here.

## ✅ Outcome
What was successfully completed?

EOF

done

echo "✅ 50 Azure Day folders with README.md created successfully!"