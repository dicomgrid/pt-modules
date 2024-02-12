resource "aws_ec2_transit_gateway_connect" "main" {
  protocol                                        = var.protocol
  tags                                            = local.tags
  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation
  transit_gateway_id                              = var.transit_gateway_id
  transport_attachment_id                         = var.transport_attachment_id
}

resource "aws_ec2_transit_gateway_connect_peer" "main" {
  for_each                      = var.peers
  bgp_asn                       = each.value.bgp_asn
  inside_cidr_blocks            = each.value.inside_cidr_blocks
  peer_address                  = each.value.peer_address
  tags                          = merge(local.tags, try(each.value.tags, {}), { Name = each.key })
  transit_gateway_address       = each.value.transit_gateway_address
  transit_gateway_attachment_id = aws_ec2_transit_gateway_connect.main.id
}

module "attachment_route_table" {
  source = "../attachment-route-table"

  association_route_table_id = !var.transit_gateway_default_route_table_association ? var.association_route_table_id : null
  propagation_route_table_ids = var.propagation_route_table_ids
  transit_gateway_attachment_id = aws_ec2_transit_gateway_connect.main.id
}

