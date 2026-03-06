# Day 15: Create Volume Snapshot

Create a snapshot of an existing volume named xfusion-vol in us-east-1 region.

1) The name of the snapshot must be xfusion-vol-ss.

2) The description must be xfusion Snapshot.

3) Make sure the snapshot status is completed before submitting the task.

## Solution
```bash
# get volume id
aws ec2 describe-volumes --filters Name=tag:Name,Values=xfusion-vol --region us-east-1

aws ec2 create-snapshot --volume-id <volume-id> --description "xfusion Snapshot" --tag-specifications 'ResourceType=snapshot,Tags=[{Key=Name,Value=xfusion-vol-ss}]' --region us-east-1
```

