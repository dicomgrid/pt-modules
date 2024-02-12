variable "association_route_table_id" { default = null }
variable "name" { default = null }
variable "peers" { default = {} }
variable "propagation_route_table_ids" { default = [] }
variable "protocol" { default = "gre" }
variable "transit_gateway_default_route_table_association" { default = true }
variable "transit_gateway_default_route_table_propagation" { default = true }
variable "transit_gateway_id" { default = null }
variable "transport_attachment_id" { default = null }

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
