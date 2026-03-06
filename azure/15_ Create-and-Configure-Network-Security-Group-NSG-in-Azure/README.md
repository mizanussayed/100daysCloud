# Day 15: Create and Configure Network Security Group (NSG) in Azure

- create a network security group (NSG) with the following requirements:

- Name of the NSG should be nautilus-nsg.

- Add an inbound security rule named Allow-HTTP for HTTP service on port 80, with the source CIDR range of 0.0.0.0/0.

- Add another inbound security rule named Allow-SSH for SSH service on port 22, with the source CIDR range of 0.0.0.0/0.

## Steps to Create and Configure NSG in Azure
1. Log in to the Azure portal (https://portal.azure.com/).
2. In the left-hand menu, click on "Create a resource" and search for "Network Security Group". Click on "Create".
`3. Fill in the required details:
   - Subscription: Select your Azure subscription.
   - Resource group: Select an existing resource group or create a new one.
   - Name: Enter "nautilus-nsg".
   - Region: Choose the desired region for your NSG.
4. Click on "Review + create" and then "Create" to deploy the NSG
5. Once the NSG is created, navigate to the NSG resource.
6. In the NSG settings, click on "Inbound security rules" and then click on
"Add" to create a new inbound security rule.
7. For the first rule (Allow-HTTP):
    - Name: Enter "Allow-HTTP".
    - Priority: Set a priority (e.g., 100).
    - Source: Select "Any".
    - Source port ranges: Enter "*".
    - Destination: Select "Any".
    - Destination port ranges: Enter "80".
    - Protocol: Select "TCP".
    - Action: Select "Allow".
8. Click "Add" to save the first rule.
9. Repeat steps 6-8 to create the second rule (Allow-SSH) with the following details:
    - Name: Enter "Allow-SSH".
    - Priority: Set a priority (e.g., 110).
    - Source: Select "Any".
    - Source port ranges: Enter "*".
    - Destination: Select "Any".
    - Destination port ranges: Enter "22".
    - Protocol: Select "TCP".
    - Action: Select "Allow".
10. Click "Add" to save the second rule.
11. Review the inbound security rules to ensure they are configured correctly.  

## by command line
```bash
# Create NSG
az network nsg create --resource-group <ResourceGroupName> --name nautilus-nsg --location <Location>
# Add Allow-HTTP rule
az network nsg rule create --resource-group <ResourceGroupName> --nsg-name nautilus-nsg --name Allow-HTTP --priority 100 --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges 80 --access Allow --protocol Tcp
# Add Allow-SSH rule
az network nsg rule create --resource-group <ResourceGroupName> --nsg-name nautilus-nsg --name Allow-SSH --priority 110 --source-address-prefixes '*' --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges 22 --access Allow --protocol Tcp
```

