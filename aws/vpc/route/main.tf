resource "aws_route" "main" {
  route_table_id              = var.route_table_id
  destination_cidr_block      = var.destination_cidr_block
  destination_ipv6_cidr_block = var.destination_ipv6_cidr_block
  destination_prefix_list_id  = var.destination_prefix_list_id
  carrier_gateway_id          = length(regexall("cagw-", var.gateway_id)) > 0 ? var.gateway_id : null
  egress_only_gateway_id      = length(regexall("eigw-", var.gateway_id)) > 0 ? var.gateway_id : null
  gateway_id                  = length(regexall("igw-", var.gateway_id)) > 0 ? var.gateway_id : length(regexall("vgw-", var.gateway_id)) > 0 ? var.gateway_id : null
  local_gateway_id            = length(regexall("lgw-", var.gateway_id)) > 0 ? var.gateway_id : null
  nat_gateway_id              = length(regexall("nat-", var.gateway_id)) > 0 ? var.gateway_id : null
  network_interface_id        = length(regexall("eni-", var.gateway_id)) > 0 ? var.gateway_id : null
  transit_gateway_id          = length(regexall("tgw-", var.gateway_id)) > 0 ? var.gateway_id : null
  vpc_endpoint_id             = length(regexall("vpce-", var.gateway_id)) > 0 ? var.gateway_id : null
  vpc_peering_connection_id   = length(regexall("pcx-", var.gateway_id)) > 0 ? var.gateway_id : null
}
