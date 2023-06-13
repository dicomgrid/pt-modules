locals {
  subnets_by_az = {
    for s in data.aws_subnet.main : s.availability_zone => s.id...
  }
}

variable "subnets_filter" { default = "*" }
variable "vpc_name" {}
