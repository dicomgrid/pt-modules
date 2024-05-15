resource "aws_cloudwatch_log_group" "main" {
  for_each          = var.cloudwatch_log_groups
  name              = try(each.value.name, each.key)
  retention_in_days = try(each.value.logs.retention_in_days, 7)
  tags = merge(
    local.tags,
    { Name = try(each.value.name, each.key) },
    try(each.value.tags, {})
  )
}

resource "aws_customer_gateway" "main" {
  for_each    = var.customer_gateways
  bgp_asn     = each.value.bgp_asn
  ip_address  = each.value.ip_address
  type        = try(each.value.type, "ipsec.1")
  device_name = try(each.value.device_name, null)

  tags = merge(
    local.tags,
    { Name = try(each.value.name, "cgw-${each.key}") },
    try(each.value.tags, {})
  )
}

resource "aws_vpn_connection" "main" {
  for_each = var.vpns

  vpn_gateway_id     = try(each.value.vpn_gateway_id, null)
  transit_gateway_id = try(each.value.transit_gateway_id, null)

  customer_gateway_id = aws_customer_gateway.main[each.value.customer_gateway].id
  type                = "ipsec.1"

  static_routes_only  = try(each.value.vpn_connection_static_routes_only, false)
  enable_acceleration = try(each.value.enable_acceleration, false)

  outside_ip_address_type                 = try(each.value.outside_ip_address_type, "PublicIpv4")
  transport_transit_gateway_attachment_id = try(each.value.outside_ip_address_type == "PrivateIpv4" ? each.value.transport_transit_gateway_attachment_id : null, null)

  tunnel1_inside_cidr = try(each.value.tunnel1_inside_cidr, null)
  tunnel2_inside_cidr = try(each.value.tunnel2_inside_cidr, null)

  tunnel1_preshared_key = try(each.value.tunnel1_preshared_key, null)
  tunnel2_preshared_key = try(each.value.tunnel2_preshared_key, null)

  tunnel1_phase1_dh_group_numbers = try(each.value.tunnel1_phase1_dh_group_numbers, var.default_dh_group_numbers)
  tunnel2_phase1_dh_group_numbers = try(each.value.tunnel2_phase1_dh_group_numbers, var.default_dh_group_numbers)

  tunnel1_phase1_encryption_algorithms = try(each.value.tunnel1_phase1_encryption_algorithms, var.default_encryption_algorithms)
  tunnel2_phase1_encryption_algorithms = try(each.value.tunnel2_phase1_encryption_algorithms, var.default_encryption_algorithms)

  tunnel1_phase1_integrity_algorithms = try(each.value.tunnel1_phase1_integrity_algorithms, var.default_integrity_algorithms)
  tunnel2_phase1_integrity_algorithms = try(each.value.tunnel2_phase1_integrity_algorithms, var.default_integrity_algorithms)

  tunnel1_phase1_lifetime_seconds = try(each.value.tunnel1_phase1_lifetime_seconds, 28800)
  tunnel2_phase1_lifetime_seconds = try(each.value.tunnel2_phase1_lifetime_seconds, 28800)

  tunnel1_dpd_timeout_seconds = try(each.value.tunnel1_dpd_timeout_seconds, 30)
  tunnel2_dpd_timeout_seconds = try(each.value.tunnel2_dpd_timeout_seconds, 30)

  tunnel1_dpd_timeout_action = try(each.value.tunnel1_dpd_timeout_action, "clear")
  tunnel2_dpd_timeout_action = try(each.value.tunnel2_dpd_timeout_action, "clear")

  tunnel1_enable_tunnel_lifecycle_control = try(each.value.tunnel1_enable_tunnel_lifecycle_control, false)
  tunnel2_enable_tunnel_lifecycle_control = try(each.value.tunnel2_enable_tunnel_lifecycle_control, false)

  tunnel1_phase2_dh_group_numbers = try(each.value.tunnel1_phase2_dh_group_numbers, var.default_dh_group_numbers)
  tunnel2_phase2_dh_group_numbers = try(each.value.tunnel2_phase2_dh_group_numbers, var.default_dh_group_numbers)

  tunnel1_phase2_encryption_algorithms = try(each.value.tunnel1_phase2_encryption_algorithms, var.default_encryption_algorithms)
  tunnel2_phase2_encryption_algorithms = try(each.value.tunnel2_phase2_encryption_algorithms, var.default_encryption_algorithms)

  tunnel1_phase2_integrity_algorithms = try(each.value.tunnel1_phase2_integrity_algorithms, var.default_integrity_algorithms)
  tunnel2_phase2_integrity_algorithms = try(each.value.tunnel2_phase2_integrity_algorithms, var.default_integrity_algorithms)

  tunnel1_phase2_lifetime_seconds = try(each.value.tunnel1_phase2_lifetime_seconds, 3600)
  tunnel2_phase2_lifetime_seconds = try(each.value.tunnel2_phase2_lifetime_seconds, 3600)

  tunnel1_rekey_fuzz_percentage = try(each.value.tunnel1_rekey_fuzz_percentage, null)
  tunnel2_rekey_fuzz_percentage = try(each.value.tunnel2_rekey_fuzz_percentage, null)

  tunnel1_rekey_margin_time_seconds = try(each.value.tunnel1_rekey_margin_time_seconds, null)
  tunnel2_rekey_margin_time_seconds = try(each.value.tunnel2_rekey_margin_time_seconds, null)

  tunnel1_replay_window_size = try(each.value.tunnel1_replay_window_size, null)
  tunnel2_replay_window_size = try(each.value.tunnel2_replay_window_size, null)

  tunnel1_startup_action = try(each.value.tunnel1_startup_action, null)
  tunnel2_startup_action = try(each.value.tunnel2_startup_action, null)

  tunnel1_ike_versions = try(each.value.tunnel1_ike_versions, null)
  tunnel2_ike_versions = try(each.value.tunnel2_ike_versions, null)

  dynamic "tunnel1_log_options" {
    for_each = try([each.value.tunnel1_log_options], [])

    content {
      dynamic "cloudwatch_log_options" {
        for_each = try([tunnel1_log_options.value.cloudwatch_log_options], [])

        content {
          log_enabled       = try(cloudwatch_log_options.value.log_enabled, true)
          log_group_arn     = try(aws_cloudwatch_log_group.main[cloudwatch_log_options.value.log_group].arn, null)
          log_output_format = try(cloudwatch_log_options.value.log_output_format, "json")
        }
      }
    }
  }

  dynamic "tunnel2_log_options" {
    for_each = try([each.value.tunnel2_log_options], [])

    content {
      dynamic "cloudwatch_log_options" {
        for_each = try([tunnel2_log_options.value.cloudwatch_log_options], [])

        content {
          log_enabled       = try(cloudwatch_log_options.value.log_enabled, true)
          log_group_arn     = try(aws_cloudwatch_log_group.main[cloudwatch_log_options.value.log_group].arn, null)
          log_output_format = try(cloudwatch_log_options.value.log_output_format, "json")
        }
      }
    }
  }

  tunnel_inside_ip_version = try(each.value.tunnel_inside_ip_version, "ipv4")

  local_ipv4_network_cidr  = try(each.value.local_ipv4_network_cidr, "0.0.0.0/0")
  remote_ipv4_network_cidr = try(each.value.remote_ipv4_network_cidr, "0.0.0.0/0")

  local_ipv6_network_cidr  = try(each.value.local_ipv6_network_cidr, null)
  remote_ipv6_network_cidr = try(each.value.remote_ipv6_network_cidr, null)

  tags = merge(
    local.tags,
    { Name = try(each.value.name, each.key) },
    try(each.value.tags, {})
  )
}

### Fix tagging on Transit Gateway Attachment if it exists
resource "aws_ec2_tag" "tgwa" {

  for_each = merge([for k, v in var.vpns : { for tk, tv in merge(local.tags, { Name = "${v.transit_gateway}-to-${k}" }, try(v.tags, {})) : "${k}-${tk}" => { vpn = k, tag_key = tk, tag_value = tv } } if try(v.transit_gateway != null, false)]...)

  resource_id = aws_vpn_connection.main[each.value.vpn].transit_gateway_attachment_id
  key         = each.value.tag_key
  value       = each.value.tag_value
}
