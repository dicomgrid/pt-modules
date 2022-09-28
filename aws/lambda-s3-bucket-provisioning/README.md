# S3 Bucket Provisioning Service

The S3 bucket provisioning service is an AWS lambda function, with attached function URL, that is responsible for creating S3 buckets in specific AWS accounts for the purpose of storing Ambra imaging data for the Ambra cloud. The reason for creating buckets across accounts to enable the Ambra cloud to use 1 S3 bucket per customer to facilitate cost analysis both of API calls and on-going storage.

The S3 bucket provisioning service must "assume role" across AWS accounts to carry out its functions in all Ambra storage AWS accounts. Thus the terraform configuration creates a number of roles and policies that facilitate the role assignment.

## TODO
- Cloudtrail log bucket and configuration (for Lambda log output)
- Notify Ops automatically when the max buckets per account threshold is reached.
- Create tfvars file for Dev, UAT, and Prod once AWS accounts are known

## Prerequisites

### Credentials
Your AWS credentials must allow you to create, modify, and delete:
- AWS Lambda functions and function URLs in the primary AWS account
- IAM roles and policies in the primary AWS account
- S3 buckets, and S3 bucket encryption, and S3 bucket policy in the primary AWS account

### Ambra Storage accounts
The current Terraform code assumes that the Ambra storage accounts already exist, and that each one has the S3BucketManager role and associated S3BucketManagement policy.

### Non-Production environments
When creating the S3 Bucket Provisioning service in non-production environments, there must be at least 2 separate AWS "storage accounts" for testing purposes. This setup will allow for testing of the AWS Lambda assuming the S3BucketManager role across different accounts.

### UAT and Production environments
The number of required AWS accounts in UAT and Production depends on the number of Ambra accounts that exist in that environment.  For example, as of this writing there are around 5000 Ambra accounts in production. Each AWS account can have a maximum of 1000 S3 buckets per account.  So at a minimum, we would need 5 accounts, but of course to account for growth we need more than 5. To give us plenty of space to grow, the recommendation was that we should have 10 AWS accounts, allowing for up to 10,000 S3 buckets, which would allow Ambra accounts to double in size before changes would be required.

## Usage

### Runtime variables
- *ambra_phr_cred_access_key*: The AWS access key for the PHR AWS account
- *ambra_phr_cred_secret_key*: The AWS private key for the PHR AWS account
- *ambra_phr_account*: The AWS account that will hold the S3 bucket for Ambra personal health record imaging data. Generally this should be the primary AWS account for the environment, but it could be one of the Ambra storage accounts as well.
- *ambra_phr_bucket*: The name of the S3 bucket where Ambra PHR data will be stored.
- *aws_region*: The region where bucket provisioning operations should occu
- *environment*: The Ambra environment where the S3 bucket provisioning service is runnning, e.g. "development", "uat", "production". This value will also be tagged on S3 buckets.
- *max_buckets_per_account*: The maximum number of S3 buckets that are allowed in an Ambra storage account. If creating a bucket were to cause this number to be exceeded, the S3 Bucket Provisioning service will return an error. **At this time, there is no notification to Ops when all AWS accounts have reached the max buckets account.**
- *ambra_storage_accounts*: A Terraform set of strings containing the AWS account IDs that will hold Ambra imaging data in S3 buckets, one bucket per customer.  NOTE: This variable technically is optional. If the variable is not provided in the Lambda environment configuration, then the Lambda code will check the AWS organizations service to search for AWS accounts tagged with the key "ambra-storage". However, it is preferable to specify the storage accounts in the environment config because it makes the Lambda more efficient. The AWS org service only exists in us-east-1, and takes a few seconds to access during the initial cold Lambda startup.

## Interaction with other Ambra components

### Ambra Services
The S3 Bucket Provisioning service lambda will be called by EC2 instances that are running the Ambra Health v3Services layer. When a new customer account is created in the v3Services layer, it will call the lambda function to get the S3 bucket details. The EC2 instances must be granted the ability to call the Lambda function since the Lambda will be running using the AWS_IAM permissions model.

### Ambra Storage
Ambra storage, currently running in EC2 instances, will not directly call the AWS Lambda, but must be able to access the S3 buckets created in the Ambra storage accounts, as well as the Ambra PHR account.
