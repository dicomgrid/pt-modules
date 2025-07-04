#variable "ambra_phr_cred_access_key" {
#  description = "The AMBRA PHR storage account access key"
#  type        = string
#}

#variable "ambra_phr_cred_secret_key" {
#  description = "The Ambra PHR storage account secret key"
#  type        = string
#}

variable "ambra_storage1_account" {
  description = "AWS account ID for PHR/Orphan storage"
  type        = string
  default     = "" ##first storage account in environment
}

#variable "ambra_phr_bucket_name" {
#  description = "AWS S3 Bucket name for PHR storage"
#  type        = string
#  default     = ""
#}

#variable "ambra_orphan_bucket_name" {
#  description = "AWS S3 Bucket name for Orpaned storage"
#  type        = string
#  default     = ""
#}

variable "access_logging" {
  default = true
}

variable "object_expiration" {
  default = 14
}
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Ambra code environment"
  type        = string
  default     = ""
}

variable "max_buckets_per_account" {
  description = "The maximum number of S3 buckets in a given AWS account"
  type        = number
  default     = 750
}

variable "ambra_storage_accounts" {
  description = "A list of Ambra/Intelerad storage accounts for imaging data"
  type        = set(string)
  default     = []
}

variable "timeout" {
  default = "60"
}

variable "primary_account" {
  default = ""
}

variable "instance_role" {
  default = ""
}

# adding follow 3 variables the rare occasion where the lambda will exist on the same acct(different regions). 
#this will allow for the creation of different policies that will limit scope of allowed roles to assume
variable "s3objectmanager_policy_name" {
  default = "s3ObjectManager"
}

variable "services_instance_profile_name" {
  default = "s3-bucket-provisioning-instance-profile"
}

variable "lambda_execution_role_name" {
  default = "s3-bucket-provisioning-lambda-execution-role"
}