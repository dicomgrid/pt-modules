

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-2"
}

variable "vpc_id" {
  description = "The ID of the VPC where the subnets are located"
  type        = string
}

variable "default_tags" {
  description = "Default tags to be applied to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Creator     = "Terraform"
  }
}

variable "account_ids" {
  description = "The AWS Account ID numbers of the accounts with which you are sharing your subnet"
  type        = list(string)
}