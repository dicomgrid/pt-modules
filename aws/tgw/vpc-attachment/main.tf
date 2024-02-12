# Create the VPC attachment request
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {

  subnet_ids         = [for subnet_ids in local.az_subnets : subnet_ids[0]]
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id
  tags               = local.tags
  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation
}

module "attachment_route_table" {
  source = "../attachment-route-table"

  count = (!var.transit_gateway_default_route_table_association && var.association_route_table_id != null) || var.propagation_route_table_ids != [] ? 1 : 0
  association_route_table_id = !var.transit_gateway_default_route_table_association ? var.association_route_table_id : null
  propagation_route_table_ids = var.propagation_route_table_ids
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.main.id
}

module "connect_attachments" {
  source = "../connect-attachment"

  for_each = var.connect_attachments

  peers                                           = try(each.value.peers, {})
  protocol                                        = try(each.value.protocol, "gre")
  name                                            = try(each.value.name, null)
  tags                                            = merge(local.tags, { Name = try(each.value.name, each.key) })
  transit_gateway_id                              = var.tgw_id
  transit_gateway_default_route_table_association = try(each.value.transit_gateway_default_route_table_association, true)
  transit_gateway_default_route_table_propagation = try(each.value.transit_gateway_default_route_table_propagation, true)
  association_route_table_id = try(each.value.association_route_table_id, null)
  propagation_route_table_ids = try(each.value.propagation_route_table_ids, [])
  transport_attachment_id                         = aws_ec2_transit_gateway_vpc_attachment.main.id
}

# Create routes if any are needed to route traffic to the VPC
## A route for the VPC cidr is not needed as it is propagated by default
module "tgw_routes" {
  source = "../routes"

  for_each = var.tgw_routes

  routes            = each.value.routes
  tgw_id            = var.tgw_id
  tgw_attachment_id = aws_ec2_transit_gateway_vpc_attachment.main.id
  tgw_rtb_id        = try(each.value.tgw_rtb_id, null)
}

# Create routes if any are needed to route traffic back to the transit gateway
module "vpc_routes" {
  source = "../vpc-routes"

  for_each = var.vpc_routes

  routes              = each.value.routes
  subnets_tags_filter = try(each.value.subnets_tags_filter, null)
  vpc_id              = var.vpc_id
  tgw_id              = var.tgw_id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.main]
}
