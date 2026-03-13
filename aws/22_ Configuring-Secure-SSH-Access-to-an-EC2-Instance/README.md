# Day 22: Configuring Secure SSH Access to an EC2 Instance

## Task
- Create an EC2 instance named `xfusion-ec2` with instance type `t2.micro`.
- Ensure the `aws-client` host has an SSH key at `/root/.ssh/id_rsa` (create it only if missing).
- Add that public key to the EC2 instance so `root` can log in without a password.

## Prerequisites
- AWS CLI configured on `aws-client` with permission to manage EC2.
- Existing VPC, subnet, and security group.
- Security group allows inbound SSH (`22`) from the `aws-client` source IP.

## Steps

### 1. Launch EC2 instance using ClickOps (AWS Console

### 2. Create SSH key on `aws-client` (if missing)

```bash
# Create key pair only if not present
ssh-keygen -t rsa -b 2048 -f /root/.ssh/id_rsa -N ""
```
### 3. Copy key to EC2 and enable root key-based login

```bash
# First login must use the key pair selected at launch
# Amazon Linux user: ec2-user | Ubuntu user: ubuntu
ssh -i /path/to/launch-key.pem ec2-user@"$EC2_IP"

# If login works, push your aws-client key to ec2-user
exit
ssh-copy-id -i /root/.ssh/id_rsa.pub -o IdentityFile=/path/to/launch-key.pem ec2-user@"$EC2_IP"

# Connect as default user and add the same key to root
ssh -i /root/.ssh/id_rsa ec2-user@"$EC2_IP"
sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh
sudo sh -c 'cat /home/ec2-user/.ssh/authorized_keys >> /root/.ssh/authorized_keys'
sudo chmod 600 /root/.ssh/authorized_keys

# Enable root public-key login if disabled
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
sudo systemctl restart sshd

exit

# Validate root login with key
ssh -i /root/.ssh/id_rsa root@"$EC2_IP"
```

## If You Get `Permission denied (publickey,...)`

1. Confirm instance key pair in EC2 Console:
    - EC2 -> Instances -> select instance -> **Details** -> **Key pair name**.
2. Use the matching private key file in SSH:
    - `ssh -i /path/to/<keypair>.pem ec2-user@<EC2_IP>`
3. Ensure permissions on key file:
    - `chmod 400 /path/to/<keypair>.pem`
4. Ensure correct username:
    - Amazon Linux: `ec2-user`
    - Ubuntu: `ubuntu`
5. If you do not have the private key anymore:
    - Use **EC2 Instance Connect** from the console to access the instance.
    - Then add your public key manually to `/home/ec2-user/.ssh/authorized_keys` (or `/home/ubuntu/.ssh/authorized_keys`).

## Validation Checklist
- Instance exists with name tag `xfusion-ec2` and type `t2.micro`.
- `/root/.ssh/id_rsa` exists on `aws-client`.
- `ssh -i /root/.ssh/id_rsa root@<EC2_IP>` from `aws-client` works without password prompt.