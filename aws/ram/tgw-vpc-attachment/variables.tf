#creating a map of all subnets in an az per vpc
locals {
  az_subnets = {
    for s in data.aws_subnet.main : s.availability_zone => s.id...
  }
}

variable "tgw_id" {
  description = "The tgw id of the tgw that is to be shared"
}

variable "vpc_id" {
  description = "The ID of the VPC where the subnets are located"
  type        = string
}

variable "destination_cidr_blocks" {
  default = []
}

variable "routes_subnet_name_values" {
  description = "List of tag:Name values to filter subnets' route tables the routes should be added to. Default [] is all subnets for VPC"
  type        = set(string)
  default     = []
}

variable "tgwa_subnet_name_values" {
  description = "List of tag:Name values to filter subnets the TGW should be attached to. Default [] is any subnets for VPC"
  type        = set(string)
  default     = []

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