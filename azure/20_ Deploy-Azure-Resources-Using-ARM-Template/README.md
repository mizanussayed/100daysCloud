# Day 20: Deploy Azure Resources Using ARM Template

## 🎯You are tasked with modifying an ARM template for deploying a virtual network. The current template is located in the /root/arm-templates directory under the filename vnet-deployment-template.json. You need to make the following changes to the template:

Change the name and displayName tag of the virtual network to arm-vnet-nautilus.

Update the addressPrefixes to 192.168.0.0/16.

Add one more tag named Environment with value KKE-nautilus.

After making these changes, you need to deploy the ARM template using the Azure CLI.

Use the following command to find out the resource group to use:

```bash
az group list --query '[].name' --output table | grep 'kml'
```


## 🔧Steps to Modify and Deploy the ARM Template
1. **Navigate to the ARM Template Directory**:

```bash
   cd /root/arm-templates
 ```
2. **Open the ARM Template for Editing**:
```bash
   vi vnet-deployment-template.json
 ```
3. **Modify the ARM Template**:
- Change the name and displayName tag of the virtual network to arm-vnet-nautilus
- Update the addressPrefixes to 192.168.0.0/16
- Add one more tag named Environment with value KKE-nautilus
4. **Save and Exit the Editor**.
5. **Deploy the ARM Template Using Azure CLI**:
```bash
    az deployment group create --resource-group <your-resource-group-name> --template-file vnet-deployment-template.json
```
1. **Verify the Deployment**:
```bash
    az deployment group show --resource-group <your-resource-group-name> --name <deployment-name>
```
# ✅Expected Outcome
- The ARM template should be successfully deployed, creating a virtual network named arm-vnet-nautilus with the specified address prefix and tags.
- You should see the deployment details confirming the successful creation of the virtual network when you verify the deployment.
## 📚Additional Resources

```json
~/arm-templates ➜  cat vnet-deployment-template.json 
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {},
    "functions": [],
    "variables": {},
    "resources": [
        {
            "name": "arm-vnet-nautilus",
            "type": "Microsoft.Network/virtualNetworks",
            "apiVersion": "2023-11-01",
            "location": "[resourceGroup().location]",
            "tags": {
                "displayName": "arm-vnet-nautilus",
                "Environment" :"KKE-nautilus"
            },
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "192.168.0.0/16"
                    ]
                }
            }
        }
    ],
    "outputs": {
    }
}
```
