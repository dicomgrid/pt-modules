resource "aws_route" "main" {
  for_each = toset(var.destination_cidr_blocks)

  route_table_id         = var.rtb_id
  destination_cidr_block = each.key
  transit_gateway_id     = var.tgw_id
}

