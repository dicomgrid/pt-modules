resource "aws_ec2_transit_gateway" "main" {

  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  description                     = var.description
  dns_support                     = var.dns_support
  multicast_support               = var.multicast_support
  transit_gateway_cidr_blocks     = var.transit_gateway_cidr_blocks
  vpn_ecmp_support                = var.vpn_ecmp_support
  tags                            = local.tags
}

module "route_table" {
  source = "./route-table"

  for_each = var.route_tables

  create_route_table = try(each.value.create_route_table, true)
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  transit_gateway_route_table_id = try(each.value.transit_gateway_route_table_id, null)
  association_attachments = try(each.value.association_attachments, [])
  propagation_attachments = try(each.value.propagation_attachments, [])
  tags = merge(local.tags, { Name = "${local.tags.Name}-${each.key}" })
}
