locals {
  rulesets = { for service in var.services : format("${service.protocol}%s-%s", service.from_port, service.from_port) => service }
}

variable "description" {}
variable "direction" {}
variable "egress" {
  type    = map(any)
  default = {}
}
variable "services" {}
variable "subnets" {}
variable "vpc_name" {}

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