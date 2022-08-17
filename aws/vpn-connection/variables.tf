variable "customer_gateway_name" {}

variable "vpn_gateway" {}

variable "vpn_type" {
  default = "ipsec.1"
}

variable "remote_subnets" {}

variable "aws_subnets" {}

variable "preshared_key" {}

variable "ike_version" {
  default = ["ikev2"]
}

variable "p1_dh_group_numbers" {}

variable "p1_encryption" {
  default = ["AES256"]
}

variable "p1_integrity_algorithms" {
  type    = list(string)
  default = ["SHA2-256", "SHA2-384", "SHA2-512"]
}

variable "dpd_timeout" {
  default = "30"
}

variable "p2_dh_group_numbers" {}

variable "p2_encryption" {
  default = ["AES256"]
}

variable "p2_integrity_algorithms" {
  type    = list(string)
  default = ["SHA2-256", "SHA2-384", "SHA2-512"]
}



variable "environment" {
  default = "Production"
}

variable "creator" {
  default = "Terraform"
}

variable "name" {}

variable "owner" {
  default = "Platform"
}
