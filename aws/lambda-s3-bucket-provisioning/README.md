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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.assume_s3_bucket_manager_in_sub_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3objectmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_for_s3_bucket_provisioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.s3_bucket_provisioning_assume_sub_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3objectmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_alias.lambda_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_function.s3_bucket_provisioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_url.s3_bucket_provisioning_alias_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url) | resource |
| [aws_lambda_function_url.s3_bucket_provisioning_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url) | resource |
| [aws_s3_bucket.ambra_orphan_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.ambra_phr_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.ambra_orphan_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.ambra_phr_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.ambra_orphan_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.ambra_phr_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.ambra_orphan_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.ambra_phr_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.ambra_orphan_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.ambra_phr_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy.AWSOrganizationsReadOnlyAccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.ambra_orphan_bucket_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ambra_phr_bucket_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_s3_bucket_manager_in_sub_account_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3-bucket-provisioning-instance-profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ambra_storage1_account"></a> [ambra\_storage1\_account](#input\_ambra\_storage1\_account) | AWS account ID for PHR/Orphan storage | `string` | `""` | no |
| <a name="input_ambra_storage_accounts"></a> [ambra\_storage\_accounts](#input\_ambra\_storage\_accounts) | A list of Ambra/Intelerad storage accounts for imaging data | `set(string)` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Ambra code environment | `string` | `""` | no |
| <a name="input_instance_role"></a> [instance\_role](#input\_instance\_role) | n/a | `string` | `""` | no |
| <a name="input_max_buckets_per_account"></a> [max\_buckets\_per\_account](#input\_max\_buckets\_per\_account) | The maximum number of S3 buckets in a given AWS account | `number` | `750` | no |
| <a name="input_primary_account"></a> [primary\_account](#input\_primary\_account) | n/a | `string` | `""` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | n/a | `string` | `"60"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->