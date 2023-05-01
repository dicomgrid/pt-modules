variable "attributes" {
  default = [
    {
      name = "LockID"
      type = "S"
    }
  ]
}
variable "billing_mode" { default = "PAY_PER_REQUEST" }
variable "hash_key" { default = "LockID" }
variable "range_key" { default = null }
variable "read_capacity" { default = null }
variable "write_capacity" { default = null }

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
