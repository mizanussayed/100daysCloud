# Day 9: Enable Termination Protection for EC2 Instance

### task:
- An Instance named nautilus-ec2 already exists in us-east-1 region. Enable termination protection for this instance.

### solution:
1. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
2. In the navigation pane, choose **Instances**.
3. Select the instance named **nautilus-ec2**.
4. Choose **Actions**, **Instance Settings**, and then **Change Termination Protection**.
5. In the **Change Termination Protection** dialog box, select **Enable**.
6. Choose **Save**.

### by command line:
```bash
## get instance id
aws ec2 describe-instances --filters "Name=tag:Name,Values=nautilus-ec2" --query "Reservations[].Instances[].InstanceId" --output text

## enable termination protection
aws ec2 modify-instance-attribute --instance-id <instance-id> --no-disable-api-termination
```