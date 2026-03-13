# Day 22: Configuring Instances with User Data

## Objective
Create an Ubuntu VM named datacenter-vm, run a startup script (user data / cloud-init) that installs and starts Nginx, and allow HTTP (port 80) from the internet.

## Target Outcome
- VM name: datacenter-vm
- OS: Ubuntu image
- Startup automation: installs and starts Nginx
- NSG rule: inbound TCP 80 allowed
- Validation: opening VM public IP in browser shows Nginx default page

## User Data Script (Install + Start Nginx)
Use this exact script during VM creation:

```bash
#cloud-config
package_update: true
packages:
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
```

Alternative shell script form:

```bash
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
```

## Full Process - Azure Portal

### 1) Create Resource Group
1. Open Azure Portal.
2. Go to Resource groups -> Create.
3. Enter:
   - Resource group: rg-day22
   - Region: any preferred region
4. Click Review + create -> Create.

### 2) Create Virtual Network
1. Go to Virtual networks -> Create.
2. Enter:
   - Name: vnet-day22
   - Address space: 10.22.0.0/16
   - Subnet: subnet-web (10.22.1.0/24)
3. Create the VNet.

### 3) Create Network Security Group (NSG)
1. Go to Network security groups -> Create.
2. Name: nsg-day22.
3. Open the NSG -> Inbound security rules -> Add:
   - Source: Any
   - Source port ranges: *
   - Destination: Any
   - Service: HTTP
   - Destination port ranges: 80
   - Protocol: TCP
   - Action: Allow
   - Priority: 1000
   - Name: allow-http-80
4. Save rule.

### 4) Create VM with User Data
1. Go to Virtual machines -> Create.
2. Basics tab:
   - Resource group: rg-day22
   - Virtual machine name: datacenter-vm
   - Image: Ubuntu Server (any recent LTS)
   - Size: as required
   - Authentication type: SSH key or password
3. Networking tab:
   - Virtual network: vnet-day22
   - Subnet: subnet-web
   - Network security group: nsg-day22 (or VM-level NSG with HTTP allowed)
4. Advanced tab:
   - Paste the User Data Script in Custom data / cloud-init.
5. Review + create -> Create.

### 5) Verify Nginx
1. After deployment, open VM overview and copy Public IP.
2. In browser, open http://<PUBLIC_IP>.
3. Expected result: Nginx welcome page.

## Full Process - Azure CLI

### 1) Set variables
```bash
RG="kml_rg_main-6c8fe25444334506"
LOCATION="eastus"
VNET="datacenter-vnet"
SUBNET="subnet-web"
NSG="datacenter-nsg"
VM="datacenter-vm"
USER="azureuser"
IMAGE="Ubuntu2204"
```

### 2) Create Resource Group, VNet, Subnet, NSG, and HTTP rule
```bash
# az group create --name $RG --location $LOCATION

az network vnet create \
  --resource-group $RG \
  --name $VNET \
  --address-prefixes 10.22.0.0/16 \
  --subnet-name $SUBNET \
  --subnet-prefixes 10.22.1.0/24

az network nsg create --resource-group $RG --name $NSG

az network nsg rule create \
  --resource-group $RG \
  --nsg-name $NSG \
  --name allow-http-80 \
  --priority 1000 \
  --access Allow \
  --direction Inbound \
  --protocol Tcp \
  --source-address-prefixes '*' \
  --source-port-ranges '*' \
  --destination-address-prefixes '*' \
  --destination-port-ranges 80
```

### 3) Create cloud-init file
Create a file named cloud-init.txt with:

```yaml
#cloud-config
package_update: true
packages:
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
```

### 4) Create VM using cloud-init
```bash
az vm create \
  --resource-group $RG \
  --name $VM \
  --image $IMAGE \
  --admin-username $USER \
  --generate-ssh-keys \
  --vnet-name $VNET \
  --subnet $SUBNET \
  --nsg $NSG \
  --custom-data cloud-init.txt \
  --public-ip-sku Standard
```

### 5) Validate service
```bash
PUBLIC_IP=$(az vm show -d -g $RG -n $VM --query publicIps -o tsv)
echo $PUBLIC_IP
curl -I http://$PUBLIC_IP
```

Expected output should include HTTP/1.1 200 OK.

## Troubleshooting
- Nginx not running:
  - SSH into VM and run: sudo systemctl status nginx
  - Start manually: sudo systemctl start nginx
- Cloud-init did not execute:
  - Check logs: sudo cat /var/log/cloud-init-output.log
- Port 80 inaccessible:
  - Confirm NSG inbound rule for TCP 80 is present and attached to VM NIC/subnet.

## Cleanup (Optional)
```bash
az group delete --name rg-day22 --yes --no-wait
```



