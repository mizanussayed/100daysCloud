# Day 50: Expanding EC2 Instance Storage for Development Needs

## 🎯 task:

1. Identify Volume: Find the volume attached to the devops-ec2 instance.

2. Expand Volume: Increase the volume size from 8 GiB to 12 GiB.

3. Reflect Changes: Ensure the root (/) partition within the instance reflects the expanded size from 8 GiB to 12 GiB.

4. SSH Access: Use the key pair located at /root/devops-keypair.pem on the aws-client host to SSH into the EC2 instance.


```bash
# Connect to the EC2 instance using SSH
ssh -i /path/to/your/key.pem ec2-user@<EC2-PUBLIC-IP>

## Check the current disk space and partitions
sudo lsblk

## Use growpart to expand the partition (assuming /dev/xvda1 is the root partition)
sudo growpart /dev/xvda 1

## Check the new partition size
sudo lsblk

## Expand the filesystem to use the new partition size
sudo df -TH

## Use xfs_growfs to expand the filesystem (assuming it's XFS)
sudo xfs_growfs -d /

## check the new size of the root volume
sudo df -TH
```


## Video Walkthrough:

[![Expanding EC2 Instance Storage](https://img.youtube.com/vi/36JAdU6RlgI/0.jpg)](https://youtu.be/36JAdU6RlgI)