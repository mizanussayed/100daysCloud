# Day 4: Enable Versioning for S3 Bucket

## Task:
The s3 bucket name is datacenter-s3-22661, enable versioning for this bucket.
Create the resources only in us-east-1 region.

## Steps:
1. Log in to the AWS Management Console at https://aws.amazon.com/console/.
2. Navigate to the S3 service by searching for "S3" in the search bar and selecting it from the results.
3. In the S3 dashboard, find the bucket named "datacenter-s3-22661" and click on its name to open the bucket details.
4. In the bucket details page, click on the "Properties" tab.
5. Scroll down to the "Bucket Versioning" section and click on it to expand the options.
6. Click on the "Edit" button to modify the versioning settings.
7. Select the "Enable" option to enable versioning for the bucket.
8. Click on the "Save changes" button to apply the new versioning settings.

## By command line:
```bash
# Optional: verify AWS credentials/profile first (Security Token Service)
aws sts get-caller-identity 

# Create the bucket in us-east-1 (high-level S3 command) 
aws s3 mb s3://datacenter-s3-22661 --region us-east-1

# Enable versioning for the S3 bucket
aws s3api put-bucket-versioning --bucket datacenter-s3-22661 --versioning-configuration Status=Enabled --region us-east-1

# Verify versioning status
aws s3api get-bucket-versioning --bucket datacenter-s3-22661 --region us-east-1
```


