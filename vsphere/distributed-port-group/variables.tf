variable "name" {}

variable "datacenter" {}

variable "vds" {
  default = ""
}

variable "vds_map" {
  type = map(any)
  default = {
    "atl2" = "DSwitch-Atl"
    "nas6" = "Cisco-NAS6"
    "nas1" = "DSwitch-NAS1"
    "mna"  = "mna-mgt-vds"
    "dfw"  = "dfw-vds"
    "dfw-mgt"  = "dfw-mgt-vds"
  }
}

variable "vlan_id" {
  default = null
}

variable "active_uplinks" {
  default = null
}

variable "standby_uplinks" {
  default = null
}

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