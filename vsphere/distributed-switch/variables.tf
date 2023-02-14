variable "name" {}

variable "datacenter" {}

variable "uplinks" {}

variable "network_resource_control_enabled" {
  default = "true"
}

variable "netflow_sampling_rate" {
  default = "4096"
}

variable "ignore_other_pvlan_mappings" {
  default = "false"
}

variable "max_mtu" {
  default = "1500"
}