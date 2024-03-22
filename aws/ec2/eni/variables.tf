variable "subnet_id" {}
variable "private_ips" { default = [] }
variable "security_groups" { default = [] }
variable "description" { default = null }
variable "source_dest_check" { default = true }
variable "instance_id" { default = null }
variable "device_index" { default = null }
variable "eips" { default = [] }
variable "eip" { default = { enabled = false } }

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
