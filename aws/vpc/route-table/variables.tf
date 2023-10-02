variable "propagating_vgws" { default = [] }
variable "routes" { default = {} }
variable "route_table_associations" { default = {} }
variable "vpc_id" {}

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