variable "account_id" {}
variable "enable-subnet-logs" { default = false }
variable "enable-vpc-logs" { default = false }
variable "enable-eni-logs" { default = false }
variable "enable-tgw-attachment-logs" { default = false }
variable "region" {}
variable "vpc_id" {}
variable "log_destination" {}
variable "traffic_type" {}
variable "max_aggregation_interval" {}
variable "retention_in_days" { default = 180 }
variable "log_destination_type" { default = "cloud-watch-logs" }
variable "tags" {}
variable "iam_role_arn" {}
