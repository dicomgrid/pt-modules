
variable "tgw_id" {
  description = "The tgw id of the tgw that is to be shared"
}

variable "subnet_ids" {
  description = "list of subnet ids to attach to tgw. need one for each az"
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
