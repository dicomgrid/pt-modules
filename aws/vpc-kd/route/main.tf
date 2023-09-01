resource "aws_route" "main" {
  route_table_id              = var.route_table_id
  destination_cidr_block      = var.destination_cidr_block == "" ? null : var.destination_cidr_block
  destination_ipv6_cidr_block = var.destination_ipv6_cidr_block == "" ? null : var.destination_ipv6_cidr_block
  destination_prefix_list_id  = var.destination_prefix_list_id == "" ? null : var.destination_prefix_list_id
  carrier_gateway_id          = var.carrier_gateway_id == "" ? null : var.carrier_gateway_id
  egress_only_gateway_id      = var.egress_only_gateway_id == "" ? null : var.egress_only_gateway_id
  gateway_id                  = var.gateway_id == "" ? null : var.gateway_id
  instance_id                 = var.instance_id == "" ? null : var.instance_id
  nat_gateway_id              = var.nat_gateway_id == "" ? null : var.nat_gateway_id
  local_gateway_id            = var.local_gateway_id == "" ? null : var.local_gateway_id
  network_interface_id        = var.network_interface_id == "" ? null : var.network_interface_id
  transit_gateway_id          = var.transit_gateway_id == "" ? null : var.transit_gateway_id
  vpc_endpoint_id             = var.vpc_endpoint_id == "" ? null : var.vpc_endpoint_id
  vpc_peering_connection_id   = var.vpc_peering_connection_id == "" ? null : var.vpc_peering_connection_id

}