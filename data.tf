data "aws_region" "current" {}

data "aws_subnet" "private" {
  for_each = toset(flatten([
    for az in var.availability_zones :
    module.foundation.private_subnets_by_az[az]
    if contains(keys(module.foundation.private_subnets_by_az), az)
  ]))
  id = each.value
}


resource "null_resource" "validate_private_subnets" {
  lifecycle {
    precondition {
      condition     = length([for az in var.availability_zones : module.foundation.private_subnets_by_az[az] if contains(keys(module.foundation.private_subnets_by_az), az)]) >= 2
      error_message = "At least 2 private subnets are required for TrustGrid deployment in the specified availability zones."
    }
  }
}


data "aws_route_table" "private" {
  for_each  = data.aws_subnet.private
  subnet_id = each.value.id
}


data "tg_node" "registered_gateways" {
  count = 2
  fqdn  = "${tg_license.gateway_licenses[count.index].id}.intelerad.trustgrid.io"

  depends_on = [
    time_sleep.wait_for_node_registration
  ]
}

data "tg_nodes" "client_groups" {
  for_each = local.gateway_client_config.groups
  
  include_tags = each.value.include_tags
  exclude_tags = each.value.exclude_tags
}