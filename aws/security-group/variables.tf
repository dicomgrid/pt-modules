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
variable "tags" {}
variable "vpc_name" {}