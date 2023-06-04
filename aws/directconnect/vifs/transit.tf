
resource "aws_dx_hosted_transit_virtual_interface" "transit" {
  count = var.create_dx_hosted_transit_vif ? 1 : 0
  
  connection_id     = var.connection_id

  owner_account_id  = data.aws_caller_identity.current.account_id
  name              = var.dx_transit_hosted_vif_name
  vlan              = var.dx_transit_hosted_vif_vlan_id
  address_family    = var.dx_transit_hosted_vif_address_family
  bgp_asn           = var.dx_transit_hosted_vif_bgp_as
  customer_address  = var.dx_transit_hosted_vif_customer_address
  amazon_address    = var.dx_transit_hosted_vif_amazon_address
  mtu               = var.mtu_size
  
  
}

