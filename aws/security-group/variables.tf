locals { 
  ruleset = { for service in var.services : format("${service.protocol}%s-%s", service.from_port, service.from_port) => service }
}

variable "description" {}
variable "direction" {}
variable "egress" {
  type = map(any)
  default = {}
}
variable "name" {}
variable "services" {}
variable "subnets" {}
variable "tags" {
  type = map(string)
  default = {}
}
variable "vpc_names" {}