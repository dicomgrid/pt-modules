variable "association_attachments" {
  type    = set(string)
  default = []
}

variable "create_route_table" { default = true }
variable "propagation_attachments" {
  type    = set(string)
  default = []
}
variable "transit_gateway_id" { default = null }
variable "transit_gateway_route_table_id" { default = null }

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
