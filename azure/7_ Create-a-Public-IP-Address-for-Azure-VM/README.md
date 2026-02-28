# Day 7: Create a Public IP Address for Azure VM


### task: 
- allocate a Public IP address, name it as xfusion-pip.

### solution:
1. Go to Azure Portal, click Create a resource, search for Public IP address, and click Create.
2. Fill in the form as below, and click Review + create.
    - Subscription: your subscription
    - Resource group: xfusion-rg
    - Name: xfusion-pip
    - SKU: Basic
    - IP version: IPv4
    - Assignment method: Dynamic

### By Command Line Interface (CLI):
```bash
az network public-ip create \
  --resource-group xfusion-rg \
  --name xfusion-pip \
  --sku Basic \
  --version IPv4 \
  --allocation-method Dynamic
```


