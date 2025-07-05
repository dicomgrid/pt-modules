variable "allow_validation_record_overwrite" {
  default = true
}
variable "domain_name" {}
variable "subject_alternative_names" {
  default = []
  type    = list(string)
}
variable "validation_record_ttl" {
  default = 60
  type    = number
}
variable "validation_method" {
  default = "DNS"
}
variable "wildcard" {
  default = false
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