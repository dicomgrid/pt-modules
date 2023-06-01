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

variable "default_tags" {
  description = "Default tags to be applied to all resources"
  type        = map(string)
  default = {

  }
}


variable "destination_cidr_blocks" {
  default = []
}