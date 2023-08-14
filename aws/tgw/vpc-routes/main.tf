resource "aws_route" "main" {
  for_each = local.route_sets

  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr_block
  transit_gateway_id     = var.tgw_id
}
