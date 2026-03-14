# Day 23: Data Migration Between S3 Buckets Using AWS CLI

## 🎯 task is to perform the following:

Create a New Private S3 Bucket: Name the bucket devops-sync-1226.

Data Migration: Migrate the entire data from the existing devops-s3-86 bucket to the new devops-sync-1226 bucket.

Ensure Data Consistency: Ensure that both buckets have the same data.

Use AWS CLI: Use the AWS CLI to perform the creation and data migration tasks.

Notes:

Create the resources only in us-east-1 region.

## Solution:
```bash
# Create a new private S3 bucket
aws s3 mb s3://devops-sync-1226 --region us-east-1

# Migrate data from the existing bucket to the new bucket
aws s3 sync s3://devops-s3-86 s3://devops-sync-1226

# Verify that the data has been migrated successfully
aws s3 ls s3://devops-sync-1226 --recursive
```

