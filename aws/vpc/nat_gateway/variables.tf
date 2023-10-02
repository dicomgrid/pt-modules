# NAT GW
variable "allocation_id" { default = null }
variable "availability_zone" {}
variable "connectivity_type" { default = null }
variable "private_ip" { default = null }
variable "secondary_allocation_ids" { default = null }
variable "secondary_private_ip_address_count" { default = null }
variable "secondary_private_ip_addresses" { default = null }
variable "subnet_id" {}

# EIP
variable "address" { default = null }
variable "associate_with_private_ip" { default = null }
variable "customer_owned_ipv4_pool" { default = null}
variable "domain" { default = "vpc" }
variable "instance" { default = null }
variable "network_border_group" {}
variable "network_interface" { default = null }
variable "public_ipv4_pool" { default = null}

# Tags
locals {
  default_tags = {
    Backups                  = var.backups
    CodeManaged              = var.code_managed
    Compliance               = var.compliance
    OneTime                  = var.onetime
    aws-migration-project-id = var.aws_project_id
    map-migrated             = var.map_migrated
  }
  tags = merge(local.default_tags, var.tags)
}
variable "tags" {}

variable "aws_project_id" { default = "null" }
variable "backups" { default = "null" }
variable "code_managed" { default = "true" }
variable "compliance" { default = "null" }
variable "map_migrated" { default = "null" }
variable "onetime" { default = "null" }
