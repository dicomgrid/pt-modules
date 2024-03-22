resource "aws_ec2_transit_gateway_route_table" "main" {
  count              = var.create_route_table ? 1 : 0
  transit_gateway_id = var.transit_gateway_id
  tags               = merge(local.tags, { Name = "${local.tags.Name}-rtb" })
}

resource "aws_ec2_transit_gateway_route_table_association" "main" {
  for_each                       = var.association_attachments
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = try(aws_ec2_transit_gateway_route_table.main[0].id, var.transit_gateway_route_table_id)
}

resource "aws_ec2_transit_gateway_route_table_propagation" "main" {
  for_each                       = var.propagation_attachments
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = try(aws_ec2_transit_gateway_route_table.main[0].id, var.transit_gateway_route_table_id)
}

resource "aws_ec2_transit_gateway_route" "main" {
  for_each                       = var.routes
  blackhole                      = try(each.value.blackhole, null)
  destination_cidr_block         = each.value.destination_cidr_block
  transit_gateway_attachment_id  = try(each.value.blackhole, false) ? each.value.transit_gateway_attachment_id : null
  transit_gateway_route_table_id = try(aws_ec2_transit_gateway_route_table.main[0].id, var.transit_gateway_route_table_id)
}
