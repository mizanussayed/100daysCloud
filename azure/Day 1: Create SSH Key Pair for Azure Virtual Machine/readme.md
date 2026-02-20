
## Create SSH Key Pair for Azure Virtual Machine

### task: create an SSH key pair with the following requirements:

- The name of the SSH key pair should be xfusion-kp.

- The key pair type must be rsa.

### Solution:
1. Open the Azure portal and navigate to the "SSH keys" section.
2. Click on the "Add" button to create a new SSH key pair.
3. In the "Create SSH key pair" form, enter "xfusion-kp" as the name of the SSH key pair.
4. Select "RSA" as the key pair type.
5. Click on the "Create" button to generate the SSH key pair.

## by command line:
1. Open the Azure Cloud Shell or your local terminal with Azure CLI installed.
2. Run the following command to create an SSH key pair named "xfusion-kp" with RSA type:
```bash
az sshkey create --name xfusion-kp --type rsa
```
3. show the created SSH key pair:
```bash
az sshkey show --name xfusion-kp
```
4. delete the created SSH key pair:
```bash
az sshkey delete --name xfusion-kp --resource-group <your-resource-group-name>
```
