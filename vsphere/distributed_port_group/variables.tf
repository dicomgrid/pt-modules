#### GLOBAL NETWORK PARAMS
variable "client_code" {}
variable "vlan_fe" {}
variable "vlan_be" {}
variable "dc" {}
variable "port_group_fe" {}
variable "port_group_be" {}
variable "dswitch" {}

#variable "dc_map" {
#  type = map
#  default = {
#    "atl" = "ATL"
#    "nas" = "NAS6"
#    "nas1" = "NAS1"
#    "lab"  = "LAB-DC"
#  }
#}

# Distributed Virtual switch used
#variable "dswitch" {
#  type = map
#  default = {
#    "atl" = "DSwitch-Atl"
#    "nas" = "Cisco-NAS6"
#    "nas1" = "DSwitch-NAS1"
#    "lab"  = "DSW-LAB-VM"
#  }
#}  

variable "fe_network_params" {
  default = {
    domain        = "radiustoday.com"
    label         = "fe"
  }
}

variable "be_network_params" {
  default = {
    domain        = "radiustoday.com"
    label         = "be"
  }
}