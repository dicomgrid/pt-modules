resource "aws_dx_gateway" "example" {
  count = var.create_dx_gateway ? 1 : 0
  name            = var.dx_gateway_name
  amazon_side_asn = var.amazon_side_asn
}



resource "aws_dx_transit_virtual_interface" "transit" {
  count = var.create_dx_hosted_transit_vif ? 1 : 0
  
  connection_id     = var.connection_id
  dx_gateway_id     = var.dx_gateway_id
  name              = var.dx_transit_vif_name
  vlan              = var.dx_transit_vif_vlan_id
  address_family    = var.dx_transit_vif_address_family
  bgp_asn           = var.dx_transit_vif_bgp_as
  customer_address  = var.dx_transit_vif_customer_address
  amazon_address    = var.dx_transit_vif_amazon_address
  mtu               = var.mtu_size
  
  
}
