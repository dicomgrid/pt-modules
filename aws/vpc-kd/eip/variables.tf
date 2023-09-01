variable "address" {
  type    = string
  default = ""
}

variable "associate_with_private_ip" {
  type    = string
  default = ""
}

variable "customer_owned_ipv4_pool" {
  type    = string
  default = ""
}

variable "instance" {
  type    = string
  default = ""
}

variable "network_border_group" {
  type    = string
  default = ""
}

variable "network_interface" {
  type    = string
  default = ""
}

variable "public_ipv4_pool" {
  type    = string
  default = ""
}

variable "vpc" {
  type    = string
  default = ""
}

variable "tags" {
  type = any
}

