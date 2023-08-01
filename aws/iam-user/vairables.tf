variable "aws_policies" { default = [] }
variable "create_access_key" { default = false }
variable "groups" { default = [] }
variable "inline_policy" { default = null }
variable "path" { default = null }
variable "pgp_public_key" { default = null }
variable "service_account" { default = false }
variable "service_account_map" {
  type = map(any)
  default = {
    true  = false
    false = true
  }
}
# Tags
locals {
  default_tags = {
    CodeManaged              = var.code_managed
    Compliance               = var.compliance
    Email                    = var.email
    Name                     = "iam_user:${var.name}"
    OneTime                  = var.onetime
    Product                  = var.product
    User_Name                = "${var.first_name} ${var.last_name}"
    User_Type                = var.user_type
    aws-migration-project-id = var.aws_project_id
    map-migrated             = var.map_migrated
  }
  tags = merge(local.default_tags, var.tags)
}
variable "tags" {}

variable "aws_project_id" { default = "null" }
variable "code_managed" { default = "true" }
variable "compliance" { default = "null" }
variable "email" {}
variable "first_name" {}
variable "last_name" {}
variable "map_migrated" { default = "null" }
variable "name" {}
variable "onetime" { default = "null" }
variable "product" { default = "iam" }
variable "user_type" {}