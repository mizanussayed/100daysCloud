# Day 10: Attach Public IP to Azure Virtual Machine
### task:
- An existing VM named xfusion-vm-pip and a public IP address named xfusion-pip already exist.
- Attach the public IP xfusion-pip to the network interface of the VM xfusion-vm-pip.
- Make sure the VM is properly assigned the public IP.

### Solution:
1. From "Virtual machines" section. Select the VM named "xfusion-vm-pip" from the list of virtual machines.
2. In the VM's overview page, click on the "Networking" tab in the left-hand menu.
3. Under the "Network interfaces" section, click on the network interface associated with the VM (it should be named something like "xfusion-vm-pip-nic").
4. In the network interface's overview page, click on the "IP configurations" tab.
6. Click on the existing IP configuration (it should be named something like "ipconfig1").
7. In the IP configuration page, click on the "Public IP address" dropdown and select the existing public IP address named "xfusion-pip".
8. Click on the "Save"

### By command line:
```bash
# Get the network interface ID of the VM
NIC_ID=$(az vm show -g <resource-group-name> -n xfusion-vm-pip --query "networkInterfaceIds[0]" -o tsv)
az network nic ip-config update --ids $NIC_ID --name ipconfig1 --public-ip-address xfusion-pip
```

