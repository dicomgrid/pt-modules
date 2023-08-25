variable "tags" {
  type = any
}

variable "vpc_name" {
  type = string
}

variable "vpc_id" {
  type = any
}

variable "route_table_name" {
  type = any
}

variable "route_table_details" {
  type = any
}


variable "carrier_gateway_id" {
  type    = any
  default = ""
}

variable "egress_only_gateway_id" {
  type    = any
  default = ""
}

variable "gateway_id" {
  type    = any
  default = ""
}

variable "instance_id" {
  type    = any
  default = ""
}

variable "nat_gateway_id" {
  type    = any
  default = ""
}

variable "local_gateway_id" {
  type    = any
  default = ""
}

variable "network_interface_id" {
  type    = any
  default = ""
}

variable "transit_gateway_id" {
  type    = any
  default = ""
}

variable "vpc_endpoint_id" {
  type    = any
  default = ""
}

variable "vpc_peering_connection_id" {
  type    = any
  default = ""
}
