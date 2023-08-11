locals {
  # Create map of AZs to subnet IDs
  az_subnets = {
    for s in data.aws_subnet.main : s.availability_zone => s.id...
  }
}

variable "tgw_routes" { default = [] }
variable "vpc_routes" { default = [] }
variable "subnets_tags_filter" {
  default     = "*"
  description = "Addtional filter option for subnets to use with VPC attachment"
}

variable "tgw_id" {}
variable "vpc_id" {}

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