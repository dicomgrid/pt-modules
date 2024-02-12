resource "aws_ec2_transit_gateway_route_table" "main" {
  count              = var.create_route_table && var.transit_gateway_id != null ? 1 : 0
  transit_gateway_id = var.transit_gateway_id
}

resource "aws_ec2_transit_gateway_route_table_association" "main" {
  for_each                       = var.association_attachments
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = try(aws_ec2_transit_gateway_route_table.main.id, var.transit_gateway_route_table_id)
}

resource "aws_ec2_transit_gateway_route_table_propagation" "main" {
  for_each                       = var.propagation_attachments
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = try(aws_ec2_transit_gateway_route_table.main.id, var.transit_gateway_route_table_id)
}
