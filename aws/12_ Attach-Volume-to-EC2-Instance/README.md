# Day 12: Attach Volume to EC2 Instanc
### task:
An instance named xfusion-ec2 and a volume named xfusion-volume already exists in us-east-1 region. Attach the xfusion-volume volume to the xfusion-ec2 instance, make sure to set the device name to /dev/sdb while attaching the volume.


### solution:
1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
2. In the navigation pane, choose "Volumes".
3. Select the volume named "xfusion-volume" from the list.
4. Click on the "Actions" button and select "Attach Volume".
5. In the "Attach Volume" dialog box, select the instance named "xfusion-ec2" from the dropdown menu.
6. Set the device name to "/dev/sdb".
7. Click on the "Attach" button to attach the volume to the instance.


### by command line:
You can also attach the volume to the EC2 instance using the AWS CLI with the following command:

```bash
# get volume-id and instance-id
aws ec2 describe-volumes --filters Name=tag:Name,Values=xfusion-volume --query "Volumes[0].VolumeId" --output text
aws ec2 describe-instances --filters Name=tag:Name,Values=xfusion-ec2 --query "Reservations[0].Instances[0].InstanceId" --output text


aws ec2 attach-volume --volume-id <volume-id> --instance-id <instance-id> --device /dev/sdb

## verify the volume is attached
aws ec2 describe-volumes --volume-ids <volume-id> --query "Volumes[0].Attachments[0].State" --output text
```
