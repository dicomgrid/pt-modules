variable "connection_id" { 
   description = "The ID of the pending directconnect connection"
   default = null
   }

variable "route_type_identifier" {
   default = "CiscoSystemsInc-Nexus9KSeriesSwitches-NXOS93"
   }
variable "confirm_dx_connection" {
    description = "Whether to confirm the directconnect connection"
    type = bool 
    default = false
   }
   
variable "create_dx_hosted_transit_vif" {
    description = "Whether to create a directconnect gateway"
    type = bool
    default = null
   }
   
variable "create_dx_gateway" {
    description = "Whether to create a directconnect gateway"
    type = bool 
    default = false
   }
variable "dx_gateway_name" {
      description = "The name of the directconnect gateway"
      default = null 
    }


variable "dx_gateway_amazon_side_as" {
      description = "The amazon side asn of the directconnect gateway"
      default = null
}
variable "dx_transit_hosted_vif_name" {
      description = "The name of the directconnect hosted transit virtual interface"
      default = null
}

variable "dx_transit_hosted_vif_vlan_id" {
      description = "The VLan ID of the directconnect hosted transit virtual interface"
      default = null
}

variable "dx_gateway_id" {
      description = "The ID of the directconnect gateway"
      default = null
}
variable "dx_transit_hosted_vif_bgp_as" {
      description = "The BGP ASN of the directconnect hosted transit virtual interface"
      default = null
}

variable "dx_transit_hosted_vif_customer_address_family" {
      description = "The customer address family of the directconnect hosted transit virtual interface"
      default = "ipv4"
}

variable "dx_transit_hosted_vif_address_family" {
      description = "The address family of the directconnect hosted transit virtual interface"
      default = "ipv4"
}
variable "dx_transit_hosted_vif_customer_address" {
      description = "The customer address of the directconnect hosted transit virtual interface"
      default = null
    }

variable "dx_transit_hosted_vif_amazon_address" {
      description = "The amazon address of the directconnect hosted transit virtual interface"
      default = null
    }

variable "mtu_size" {
     description = "The MTU size of the directconnect hosted transit virtual interface"
     default = null
}