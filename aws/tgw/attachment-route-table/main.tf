resource "aws_ec2_transit_gateway_route_table_association" "main" {
  for_each                       = var.association_route_table_id != null ? toset([var.association_route_table_id]) : []
  transit_gateway_attachment_id  = var.transit_gateway_attachment_id
  transit_gateway_route_table_id = each.value
}

resource "aws_ec2_transit_gateway_route_table_propagation" "main" {
  for_each                       = toset(var.propagation_route_table_ids)
  transit_gateway_attachment_id  = var.transit_gateway_attachment_id
  transit_gateway_route_table_id = each.value
}
