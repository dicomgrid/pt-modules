locals {
  route_sets = merge([for id in data.aws_route_tables.main.ids : { for route in var.routes : "${id}-${route}" => { route_table_id = id, destination_cidr_block = route } }]...)
}

variable "routes" {}

variable "subnets_tags_filter" {
  description = "Addtional filter option for subnets to create routes on"
  default     = null
}

variable "tgw_id" {
  description = "The tgw id of the tgw that is to be shared"
}

variable "vpc_id" {
  description = "The ID of the VPC where the subnets are located"
  type        = string
}
