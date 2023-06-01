variable "tgw_id" {
  description = "The tgw id of the tgw that is to be shared"
}


variable "vpc_id" {
  description = "The ID of the VPC where the subnets are located"
  type        = string
}


variable "rtb_id" {
  description = "The ID of the VPC where the subnets are located"
  type        = string
}

variable "destination_cidr_blocks" {}