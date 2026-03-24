# Day 28: Troubleshooting Public Virtual Network Configurations

## 🎯 task:
The Nautilus DevOps Team deployed an Nginx server on an Azure VM in a public VNet named devops-vnet. However, the server is still inaccessible from the internet.

As a DevOps team member, complete the following tasks:

Verify VNet Configuration: Ensure devops-vnet allows internet access.
Attach Public IP: A public IP named devops-pip already exists. Attach this public IP to the VM devops-vm to make it accessible from the internet.
Ensure Accessibility: Confirm the VM devops-vm is accessible on port 80.
Use the provided Azure credentials to troubleshoot and resolve the issue.

## 🧑‍💻 solution:
1. **Verify VNet Configuration**:
   - Log in to the Azure Portal using the provided credentials.
   - Navigate to the "Virtual Networks" section and select `devops-vnet`.
   - Check the "Subnets" section to ensure that there is a subnet configured for the VM.
   - Verify that the subnet has a route to the internet (check for a default route to the internet).

2. **Attach Public IP**:
   - Navigate to the "Virtual Machines" section and select `devops-vm`.
   - In the VM's overview page, click on "Networking" under the Settings section.
   - Click on the network interface associated with `devops-vm`.
   - In the network interface settings, click on "IP configurations".
    - Click on the IP configuration (e.g., `ipconfig1`).
    - Under "Public IP address", click "Associate".
    - Select the existing public IP `devops-pip` from the list and click "Save".

3. **Ensure Accessibility**:
   - After associating the public IP, wait for a few minutes for the changes to take effect.
   - Open a web browser and navigate to the public IP address associated with `devops-pip` (e.g., http://<public-ip-address>).
   - If the Nginx server is running correctly, you should see the default Nginx welcome page.
   - If you cannot access the server, check the Network Security Group (NSG) rules
        - Navigate to the NSG associated with the VM's subnet or network interface.
        - Ensure there is an inbound rule allowing traffic on port 80 (HTTP) from the internet (source: Any, destination: Any, port: 80, protocol: TCP, action: Allow). 
    - If the rule is missing, add a new inbound rule with the above specifications and save the changes.
    - After updating the NSG rules, try accessing the Nginx server again using the public IP address.

4. **Additional Troubleshooting**:
    - If the server is still inaccessible, check the VM's status in the Azure Portal to ensure it is running.
    - Verify that the Nginx service is running on the VM by connecting to it via SSH and checking the service status (e.g., `sudo systemctl status nginx`).
    - Check for any firewall rules on the VM that might be blocking incoming traffic on port 80.
    - Check the firewall status by running `sudo ufw status` (if using UFW) or checking iptables rules.
    - If necessary, allow traffic on port 80 using the appropriate firewall command (e.g
    `sudo ufw allow 80/tcp` for UFW) and then restart the firewall service.
    - If necessary, restart the Nginx service to apply any changes (e.g., `sudo systemctl restart nginx`).


