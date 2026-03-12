# Day 21: Assigning Public IP to Virtual Machines

## 🎯 A VM will be used to host a new application that requires a stable public IP address. To ensure that the VM has a consistent public IP, a Static Public IP address needs to be associated with it. The VM will be named xfusion-vm, and the Static Public IP will be named xfusion-pip. This setup will help the Development Team to have a reliable and consistent access point for their application.

- Create an Azure VM named xfusion-vm using any available Ubuntu image, with the VM size Standard_B1s.
- Generate an SSH public key on the azure-client host and associate it with the VM for SSH access.
- Associate a Static Public IP address named xfusion-pip with this VM.
- Ensure the VM is accessible via SSH using the generated public key.

## Create ssh key pair on azure-client host
```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
```

Optional (if you prefer RSA with stronger key length):
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
```

## 🛠️ Steps to Assign a Static Public IP to a VM
1. **Create a Resource Group** (if not already created):
   
```bash
   az group create --name xfusion-rg --location centralus
```
2. **Create a Virtual Network** (if not already created):
   
```bash
   az network vnet create --resource-group xfusion-rg --name xfusion-vnet --subnet-name xfusion-subnet --location centralus
```
3. **Create a Static Public IP Address**:
   
```bash
   az network public-ip create --resource-group xfusion-rg --name xfusion-pip --sku Standard --location centralus --allocation-method Static
```

4. **Create a Network Interface and Associate the Public IP**:
   
```bash
   az network nic create --resource-group xfusion-rg --name xfusion-nic --vnet-name xfusion-vnet --subnet xfusion-subnet --public-ip-address xfusion-pip --location centralus
```

5. **Create the VM and Associate the Network Interface**:
   
```bash
   az vm create --resource-group xfusion-rg --name xfusion-vm --image UbuntuLTS --size Standard_B1s --admin-username azureuser --ssh-key-values ~/.ssh/id_ed25519.pub --nics xfusion-nic
```
6. **Verify the VM and Public IP Association**:
   
```bash
   az vm show --resource-group xfusion-rg --name xfusion-vm --query "networkInterfaceIds"
   az network public-ip show --resource-group xfusion-rg --name xfusion-pip --query "ipAddress"
```
7. **SSH into the VM**:
   
```bash
   ssh azureuser@<Public-IP-Address>
```


