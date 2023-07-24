variable "direction" {}
variable "endpoint_name" { default = "default-rslvr" }
variable "rules" { default = {} }
variable "security_group_ids" {}
variable "subnet_ids" {}
variable "vpc_id" {}

variable "egress_default" {
  default = [
    {
      description = "All traffic"
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
variable "security_group" {}
variable "subnets_filter" { default = "*" }
variable "tags" {}
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