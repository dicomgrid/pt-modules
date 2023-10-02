resource "aws_route_table" "main" {
  vpc_id           = var.vpc_id
  propagating_vgws = var.propagating_vgws
  tags             = local.tags
}

module "route" {
  source = "../route"

  for_each = { for v in var.routes : v.destination_cidr_block => v }

  destination_cidr_block      = try(each.value.destination_cidr_block, null)
  destination_ipv6_cidr_block = try(each.value.destination_ipv6_cidr_block, null)
  destination_prefix_list_id  = try(each.value.destination_prefix_list_id, null)
  gateway_id                  = each.value.gateway_id
  route_table_id              = aws.route_table.id
  
}

module "route_table_association" {
  source = "../route-table-association"

  for_each = var.route_table_associations

  gateway_id = try(each.value.gateway_id, null)
  route_table_id = aws_route_table.main.id
  subnet_id = try(each.value.subnet_id, null)
}
