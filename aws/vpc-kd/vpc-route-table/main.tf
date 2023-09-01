module "route-table" {
  source = "../route_table"
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = "${var.vpc_name}-${var.route_table_name}-rtb" })
}

module "route-table-routes" {
  source                    = "../route"
  for_each                  = var.route_table_details.routes
  route_table_id            = module.route-table.id
  destination_cidr_block    = each.value.destination_cidr_block
  carrier_gateway_id        = each.value.destination_type == "carrier_gateway" ? (each.value.destination_id == "" ? var.carrier_gateway_id : each.value.destination_id) : null
  egress_only_gateway_id    = each.value.destination_type == "egress_only_gateway" ? (each.value.destination_id == "" ? var.egress_only_gateway_id : each.value.destination_id) : null
  gateway_id                = contains(["internet_gateway", "virtual_private_gateway"], each.value.destination_type) ? (each.value.destination_id == "" ? var.gateway_id : each.value.destination_id) : null
  instance_id               = each.value.destination_type == "instance" ? (each.value.destination_id == "" ? var.instance_id : each.value.destination_id) : null
  nat_gateway_id            = each.value.destination_type == "nat_gateway" ? (each.value.destination_id == "" ? var.nat_gateway_id : each.value.destination_id) : null
  local_gateway_id          = each.value.destination_type == "local_gateway" ? (each.value.destination_id == "" ? var.local_gateway_id : each.value.destination_id) : null
  network_interface_id      = each.value.destination_type == "network_interface" ? (each.value.destination_id == "" ? var.network_interface_id : each.value.destination_id) : null
  transit_gateway_id        = each.value.destination_type == "transit_gateway" ? (each.value.destination_id == "" ? var.transit_gateway_id : each.value.destination_id) : null
  vpc_endpoint_id           = each.value.destination_type == "vpc_endpoint" ? (each.value.destination_id == "" ? var.vpc_endpoint_id : each.value.destination_id) : null
  vpc_peering_connection_id = each.value.destination_type == "vpc_peering_connection" ? (each.value.destination_id == "" ? var.vpc_peering_connection_id : each.value.destination_id) : null
}
