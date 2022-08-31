variable "name" {}

variable "datacenter" {}

variable "vds" {}

variable "vlan_id" {
  default = null
}

variable "active_uplinks" {}

variable "standby_uplinks" {}

variable "type" {
  default = "earlyBinding"
}

variable "block_override_allowed" {
  default = "true"
}

variable "port_config_reset_at_disconnect" {
  default = "true"
}

variable "allow_forged_transmits" {
  default = "false"
}

variable "allow_mac_changes" {
  default = "false"
}

variable "allow_promiscuous" {
  default = "false"
}

variable "auto_expand" {
  default = "true"
}

variable "min_vlan" {
  default = null
}

variable "max_vlan" {
  default = null
}