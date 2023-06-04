variable "create_dx_gateway" {
     description = "Whether to create a directconnect gateway"
     type = bool
     default = false
}
variable "connection_id" { 
   description = "The ID of the pending directconnect connection"
   }
variable "dx_transit_vif_address_family" {
    description = "The address family of the directconnect hosted transit virtual interface"
    default = "ipv4"
   }
   
variable "create_dx_transit_vif" {
    description = "Whether to create a directconnect gateway"
    type = bool
   }
   
variable "dx_transit_vif_name" {
      description = "The name of the directconnect hosted transit virtual interface"
}

variable "dx_transit_vif_vlan_id" {
      description = "The VLan ID of the directconnect hosted transit virtual interface"
}

variable "dx_transit_vif_bgp_as" {
      description = "The BGP ASN of the directconnect hosted transit virtual interface"
}

variable "dx_transit_vif_customer_address" {
      description = "The customer address of the directconnect hosted transit virtual interface"
      default = null
    }

variable "dx_transit_vif_amazon_address" {
      description = "The amazon address of the directconnect hosted transit virtual interface"
      default = null
    }

variable "mtu_size" {
     description = "The MTU size of the directconnect hosted transit virtual interface"
     default = null
}

variable "dx_gateway_name" {
     description = "The name of the directconnect gateway"
     default = null
}

variable "amazon_side_asn" {
    description = "The amazon side ASN of the directconnect gateway"
    default = null
    }