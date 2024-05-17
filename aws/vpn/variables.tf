variable "cloudwatch_log_groups" { default = {} }
variable "customer_gateways" { default = {} }
variable "vpns" { default = {} }

variable "default_encryption_algorithms" {
  default = ["AES256", "AES256-GCM-16"]
}

variable "default_integrity_algorithms" {
  default = ["SHA2-256", "SHA2-384", "SHA2-512"]
}

variable "default_dh_group_numbers" {
  default = ["14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
}

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
