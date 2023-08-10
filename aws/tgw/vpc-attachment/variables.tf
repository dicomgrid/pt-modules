# variable "accepter_account_id" { default = null }
# variable "accepter_region" {}
variable "subnets_tag_name" {
  default     = "*"
  description = "Addtional filter option for subnets to use with VPC attachment"
}
variable "tgw_id" {}
# variable "accepter_transit_gateway" {}
# variable "requester_routes" { default = [] }
variable "vpc_id" {}
# variable "requester_transit_gateway" {}

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