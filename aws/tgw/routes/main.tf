resource "aws_ec2_transit_gateway_route" "main" {
  for_each = toset(var.routes)

  destination_cidr_block         = each.value
  transit_gateway_attachment_id  = var.tgw_attachment_id
  transit_gateway_route_table_id = var.tgw_rtb_id == null ? data.aws_ec2_transit_gateway.main.association_default_route_table_id : var.tgw_rtb_id
}
