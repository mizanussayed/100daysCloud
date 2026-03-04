# Day 13: SSH into an Azure Virtual Machine

Configure SSH key-based access for `devops-vm` on Azure. The task requires copying the root public key from the Azure client (landing host) to the VM and validating remote access.

## Task Summary
- VM: `devops-vm` (region: `centralus`)
- Default login user: `azureuser`
- Source key (landing host): `/root/.ssh/id_rsa.pub`
- Target on VM: `/root/.ssh/authorized_keys`

## Prerequisites
- VM is running and reachable on port `22`
- NSG / firewall allows SSH inbound
- You can SSH to VM as `azureuser`

## Solution

### 1) Get VM public IP
```bash
az vm show -d -g <resource-group-name> -n devops-vm --query publicIps -o tsv
```

### 2) Copy root public key to VM (login as azureuser)
Run this on the landing host:
```bash
ssh-copy-id -i /root/.ssh/id_rsa.pub azureuser@<devops-vm-ip-address>
```

### 3) Login to VM and prepare root SSH directory
```bash
ssh azureuser@<devops-vm-ip-address>
sudo -i
mkdir -p /root/.ssh
chmod 700 /root/.ssh
```

### 4) Add key for root and fix permissions
Use one clean key line from `azureuser` key file:
```bash
awk '/^ssh-(rsa|ed25519|ecdsa)/{print; exit}' /home/azureuser/.ssh/authorized_keys > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
chown -R root:root /root/.ssh
```

### 5) Configure SSH daemon for root key login
```bash
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart ssh
```

### 6) Verify
From landing host:
```bash
ssh root@<devops-vm-ip-address>
```

---

## Troubleshooting

### Issue: `Permission denied` when checking `/root/.ssh`
Reason: `/root` is restricted; non-root user cannot access it directly.

Fix:
```bash
sudo ls -la /root/.ssh
sudo chmod 700 /root/.ssh
sudo chmod 600 /root/.ssh/authorized_keys
```


### Issue: `Please login as the user "azureuser" rather than the user "root"`
Reason: root SSH is blocked by default image policy or forced command options in root key.

Checks:
```bash
grep -E '^(#\s*)?(PermitRootLogin|PasswordAuthentication)' /etc/ssh/sshd_config
grep -nE 'Please login as the user|command=' /root/.ssh/authorized_keys || true
```

Fix:
- Ensure `PermitRootLogin yes`
- Ensure `/root/.ssh/authorized_keys` contains a normal `ssh-rsa`/`ssh-ed25519` key line without `command=...`
- Restart SSH: `systemctl restart ssh`

### Issue: `ssh-copy-id` says key already exists
This is informational. It means the key is already present for that user.

### Issue: root login still blocked
Some environments enforce no direct root SSH.

Fallback (accepted in many real setups):
```bash
ssh azureuser@<devops-vm-ip-address>
sudo -i
```

### Useful debug command
```bash
ssh -v root@<devops-vm-ip-address>
```
Use verbose output to identify whether key offer, permission checks, or server policy caused rejection.








