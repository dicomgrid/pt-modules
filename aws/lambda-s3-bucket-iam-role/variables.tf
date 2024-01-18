
variable "primary_account" {
  description = "Account Number where lambda lives"
  default     = ""
}

variable "instance_role" {
  description = "instance role that the storage ec2 instances use"
  default     = ""
}

variable "environment" {
  default = ""
}

variable "lambda_role" {
  description = "lambda execution role name"
  default = "s3-bucket-provisioning-lambda-execution-role"
}