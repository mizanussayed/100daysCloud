# Day 48: VM and ACR Integration for Storage

## 🎯 Objective
1) Azure Virtual Machine Setup:
- Create a VM named devops-vm in the East US region.
- Authentication: Use SSH public key authentication. (Please select use existing public key option, create public-key locally and paste contents of ~/.ssh/id_rsa.pub).
- Install Docker and Azure CLI on the VM.
- Pull the Docker image from the ACR and run it on the VM, ensuring it listens on port 80.

2) Azure Container Registry (ACR) Setup:
- Create an ACR named devopsacr5312  in the East US region.
- The repository name should be devops/python-app.
- Build the Docker image using the Dockerfile already given under /root/pyapp.
- Push the Docker image to the ACR with the tag latest.

3) Create a Storage Account and Blob Container:
- Create a storage account named devopsstor29182 in the East US region with Locally-redundant storage (LRS).
- Create a Blob container named devops-config.
- Upload a file named config.json (available under /root/) to the container.


## 🛠️ Solution
1) login to ACR, then build and push docker image locally
```bash
docker login devopsacr5312 .azurecr.io --username devopsacr5312  --password <ACR_PASSWORD>
docker build -t devopsacr5312 .azurecr.io/devops/python-app:latest /root/pyapp
docker push devopsacr5312 .azurecr.io/devops/python-app:latest
```

3) install docker & azure cli after ssh into VM
```bash
sudo apt update && sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

4) login to ACR from VM and pull image
```bash
docker login devopsacr5312 .azurecr.io --username devopsacr5312  --password <ACR_PASSWORD>
docker run -d -p 80:80 devopsacr5312 .azurecr.io/devops/python-app:latest --name python-app -v /root/config.json:/app/config.json
```