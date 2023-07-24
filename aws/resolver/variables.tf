variable "direction" {}
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
variable "endpoint_name" { default = "default-rslvr" }
variable "rules" { default = {} }
variable "security_group" {}
variable "subnets_filter" { default = "*" }
variable "tags" {}
variable "vpc_name" {}