variable "route_table_id" {
  type = string
}

variable "destination_cidr_block" {
  type    = string
  default = ""
}

variable "destination_ipv6_cidr_block" {
  type    = string
  default = ""
}

variable "destination_prefix_list_id" {
  type    = string
  default = ""
}

variable "carrier_gateway_id" {
  type    = string
  default = ""
}

variable "egress_only_gateway_id" {
  type    = string
  default = ""
}

variable "gateway_id" {
  type    = string
  default = ""
}

variable "instance_id" {
  type    = string
  default = ""
}

variable "nat_gateway_id" {
  type    = string
  default = ""
}

variable "local_gateway_id" {
  type    = string
  default = ""
}

variable "network_interface_id" {
  type    = string
  default = ""
}

variable "transit_gateway_id" {
  type    = string
  default = ""
}

variable "vpc_endpoint_id" {
  type    = string
  default = ""
}

variable "vpc_peering_connection_id" {
  type    = string
  default = ""
}