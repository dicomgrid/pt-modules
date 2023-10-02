resource "aws_route_table" "main" {
  vpc_id           = var.vpc_id
  propagating_vgws = var.propagating_vgws
  tags             = var.tags
}

module "route" {
  source = "../route"

  for_each = var.routes

  destination_cidr_block      = try(each.value.destination_cidr_block, null)
  destination_ipv6_cidr_block = try(each.value.destination_ipv6_cidr_block, null)
  destination_prefix_list_id  = try(each.value.destination_prefix_list_id, null)
  gateway_id = each.value.gateway_id
  route_table_id = each.value.route_table_id
}

module "route_table_association" "main" {
  source = "../route-table-association"

  for_each = var.route_table_associations

  gateway_id = try(each.value.gateway_id, null)
  route_table_id = aws_route_table.main
  subnet_id = try(each.value.subnet_id, null)
}
