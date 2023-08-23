variable "account_id" {
  type        = string
  description = "The AWS account ID used for provisioning resources"
}

variable "region" {
  description = "The region where the resources will be provisioned."
  type        = string
  default     = "us-east-2"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "log_destination" {}
variable "traffic_type" {}
variable "max_aggregation_interval" {}

variable "codemanaged" {
  type    = string
  default = "Terraform"

}
variable "retention_in_days" {
  type    = number
  default = 90
}
variable "log_destination_type" {
  type    = string
  default = "cloud-watch-logs"
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role"
  type        = string
}

variable "enable-subnet-logs" {
  type    = bool
  default = false
}
variable "enable-vpc-logs" {
  type    = bool
  default = false
}
variable "enable-eni-logs" {
  type    = bool
  default = false
}
variable "enable-tgw-attachment-logs" {
  type        = bool
  description = "Determines whether to enable logs for Transit Gateway (TGW) attachments."
  default     = false
}
variable "role_name" {
  description="Name of the iam role that will be used by CloudWatch Logs agent."
  default = "AssumeRoleFlowLog"
  }
  variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}