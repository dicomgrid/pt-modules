variable "application" { default = "default" }
variable "aws_project_id" { default = null }
variable "billing" { default = "" }
variable "byoip_pool" { default = false }
variable "creator" { default = "terraform" }
variable "domain" { default = "vpc" }
variable "environment" {}
variable "instance_id" {}
variable "map_migrated" { default = null }
variable "name" {}
variable "owner" { default = "platform" }

# Added by Pavel to accomodate Houston LZ EIP allocation
variable "network_border_group" { default = null }
variable "tags" { default = {} }

