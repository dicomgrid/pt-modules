variable "Application" { default = "default" }
variable "aws_project_id" { default = null }
variable "Billing" { default = "" }
variable "byoip_pool" { default = false }
variable "Creator" { default = "terraform" }
variable "domain" { default = "vpc" }
variable "Environment" {}
variable "instance_id" {}
variable "map_migrated" { default = null }
variable "Name" {}
variable "Owner" { default = "platform" }

# Added by Pavel to accomodate Houston LZ EIP allocation
variable "network_border_group" { default = null }
variable "tags" { default = {} }

