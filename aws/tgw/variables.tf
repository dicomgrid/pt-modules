variable "amazon_side_asn" { default = "64512" }
variable "auto_accept_shared_attachments" { default = "disable" }
variable "default_route_table_association" { default = "enable" }
variable "default_route_table_propagation" { default = "enable" }
variable "description" { default = "" }
variable "dns_support" { default = "enable" }
variable "multicast_support" { default = "disable" }
variable "transit_gateway_cidr_blocks" { default = null }
variable "vpn_ecmp_support" { default = "enable" }

# Tags
locals {
  default_tags = {
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
variable "code_managed" { default = "true" }
variable "compliance" { default = "null" }
variable "map_migrated" { default = "null" }
variable "onetime" { default = "null" }