### BGP

resource "panos_bgp" "main" {
  aggregate_med                    = var.aggregate_med
  allow_redistribute_default_route = var.allow_redistribute_default_route
  always_compare_med               = var.always_compare_med
  as_format                        = var.as_format
  as_number                        = var.as_number
  bfd_profile                      = var.bfd_profile
  confederation_member_as          = var.confederation_member_as
  default_local_preference         = var.default_local_preference
  deterministic_med_comparison     = var.deterministic_med_comparison
  ecmp_multi_as                    = var.ecmp_multi_as
  enable_graceful_restart          = var.enable_graceful_restart
  enforce_first_as                 = var.enforce_first_as
  install_route                    = var.install_route
  local_restart_time               = var.local_restart_time
  max_peer_restart_time            = var.max_peer_restart_time
  reflector_cluster_id             = var.reflector_cluster_id
  reject_default_route             = var.reject_default_route
  router_id                        = var.router_id
  stale_route_time                 = var.stale_route_time
  virtual_router                   = var.virtual_router

}


### BGP Components

resource "panos_bgp_auth_profile" "main" {
  for_each = var.auth_profiles

  virtual_router = panos_bgp.main.virtual_router
  name           = try(each.value.name, each.key)
  secret         = each.value.secret

}

resource "panos_bgp_peer_group" "main" {
  for_each = var.peer_groups

  aggregated_confed_as_path   = try(each.value.aggregated_confed_as_path, true)
  enable                      = try(each.value.enable, true)
  export_next_hop             = try(each.value.export_next_hop, null)
  import_next_hop             = try(each.value.import_next_hop, null)
  name                        = try(each.value.name, each.key)
  remove_private_as           = try(each.value.remove_private_as, each.value.type == "ebgp" ? true : null, null)
  soft_reset_with_stored_info = try(each.value.soft_reset_with_stored_info, null)
  type                        = try(each.value.type, null)
  virtual_router              = panos_bgp.main.virtual_router

}

resource "panos_bgp_peer" "main" {
  for_each = var.peers

  address_family_type                 = try(each.value.address_family_type, "ipv4")
  allow_incoming_connections          = try(each.value.allow_incoming_connections, null)
  allow_outgoing_connections          = try(each.value.allow_outgoing_connections, null)
  auth_profile                        = try(each.value.auth_profile, null)
  bfd_profile                         = try(each.value.bfd_profile, "Inherit-vr-global-setting")
  bgp_peer_group                      = panos_bgp_peer_group.main[each.value.peer_group].name
  enable_mp_bgp                       = try(each.value.enable_mp_bgp, null)
  enable_sender_side_loop_detection   = try(each.value.enable_sender_side_loop_detection, null)
  hold_time                           = try(each.value.hold_time, null)
  idle_hold_time                      = try(each.value.idle_hold_time, null)
  incoming_connections_remote_port    = try(each.value.incoming_connections_remote_port, null)
  keep_alive_interval                 = try(each.value.keep_alive_interval, null)
  local_address_interface             = each.value.local_address_interface
  local_address_ip                    = try(each.value.local_address_ip, null)
  max_prefixes                        = try(each.value.max_prefixes, "unlimited")
  min_route_advertisement_interval    = try(each.value.min_route_advertisement_interval, 30)
  multi_hop                           = try(each.value.multi_hop, null)
  name                                = try(each.value.name, each.key)
  open_delay_time                     = try(each.value.open_delay_time, null)
  outgoing_connections_local_port     = try(each.value.outgoing_connections_local_port, null)
  peer_address_ip                     = each.value.peer_address_ip
  peer_as                             = contains(["ibgp", "ibgp-confed"], panos_bgp_peer_group.main[each.value.peer_group].type) ? var.as_number : try(each.value.peer_as, null)
  peering_type                        = try(each.value.peering_type, null)
  reflector_client                    = try(each.value.reflector_client, "non-client")
  subsequent_address_family_multicast = try(each.value.subsequent_address_family_multicast, null)
  subsequent_address_family_unicast   = try(each.value.subsequent_address_family_unicast, true)
  virtual_router                      = panos_bgp.main.virtual_router

}

resource "panos_bgp_redist_rule" "main" {
  for_each = var.redist_rules

  address_family           = try(each.value.address_family, "ipv4")
  enable                   = try(each.value.enable, true)
  metric                   = try(each.value.metric, null)
  name                     = try(each.value.name, each.key)
  route_table              = try(each.value.route_table, "unicast")
  set_as_path_limit        = try(each.value.set_as_path_limit, null)
  set_communities          = try(each.value.set_communities, null)
  set_extended_communities = try(each.value.set_extended_communities, null)
  set_local_preference     = try(each.value.set_local_preference, null)
  set_med                  = try(each.value.set_med, null)
  set_origin               = try(each.value.set_origin, null)
  virtual_router           = panos_bgp.main.virtual_router

}

resource "panos_bgp_import_rule_group" "main" {
  for_each = var.import_rule_groups

  position_keyword   = try(each.value.position_keyword, null)
  position_reference = try(each.value.referencing, null)
  virtual_router     = panos_bgp.main.virtual_router

  dynamic "rule" {
    for_each = each.value.rules

    content {
      action                         = try(rule.value.action, null)
      as_path_limit                  = try(rule.value.as_path_limit, null)
      as_path_type                   = try(rule.value.as_path_type, null)
      community_type                 = try(rule.value.community_type, "none")
      community_value                = try(rule.value.community_value, null)
      dampening                      = try(rule.value.dampening, null)
      enable                         = try(rule.value.enable, true)
      extended_community_type        = try(rule.value.extended_community_type, "none")
      extended_community_value       = try(rule.value.extended_community_value, null)
      local_preference               = try(rule.value.local_preference, null)
      match_as_path_regex            = try(rule.value.match_as_path_regex, null)
      match_community_regex          = try(rule.value.match_community_regex, null)
      match_extended_community_regex = try(rule.value.match_extended_community_regex, null)
      match_from_peers               = try(rule.value.match_from_peers, null)
      match_med                      = try(rule.value.match_med, null)
      match_next_hops                = try(rule.value.match_next_hops, null)
      match_route_table              = try(rule.value.match_route_table, "unicast")
      med                            = try(rule.value.med, null)
      name                           = try(rule.value.name, "${each.key}-rg-${rule.key}")
      next_hop                       = try(rule.value.next_hop, null)
      origin                         = try(rule.value.origin, null)
      used_by                        = try(reverse(sort(rule.value.used_by)), null)
      weight                         = try(rule.value.weight, null)

      dynamic "match_address_prefix" {
        for_each = try(rule.value.match_address_prefix, {})

        content {
          exact  = try(match_address_prefix.value.exact, true)
          prefix = try(match_address_prefix.value.prefix, match_address_prefix.key)
        }
      }
    }
  }

}

resource "panos_bgp_export_rule_group" "main" {
  for_each = var.export_rule_groups

  position_keyword   = try(each.value.position_keyword, null)
  position_reference = try(each.value.referencing, null)
  virtual_router     = panos_bgp.main.virtual_router

  dynamic "rule" {
    for_each = each.value.rules

    content {
      action                         = try(rule.value.action, null)
      as_path_limit                  = try(rule.value.as_path_limit, null)
      as_path_type                   = try(rule.value.as_path_type, null)
      as_path_value                  = try(rule.value.as_path_value, null)
      community_type                 = try(rule.value.community_type, "none")
      community_value                = try(rule.value.community_value, null)
      enable                         = try(rule.value.enable, true)
      extended_community_type        = try(rule.value.extended_community_type, "none")
      extended_community_value       = try(rule.value.extended_community_value, null)
      local_preference               = try(rule.value.local_preference, null)
      match_as_path_regex            = try(rule.value.match_as_path_regex, null)
      match_community_regex          = try(rule.value.match_community_regex, null)
      match_extended_community_regex = try(rule.value.match_extended_community_regex, null)
      match_from_peers               = try(rule.value.match_from_peers, null)
      match_med                      = try(rule.value.match_med, null)
      match_next_hops                = try(rule.value.match_next_hops, null)
      match_route_table              = try(rule.value.match_route_table, "unicast")
      med                            = try(rule.value.med, null)
      name                           = try(rule.value.name, "${each.key}-rg-${rule.key}")
      next_hop                       = try(rule.value.next_hop, null)
      origin                         = try(rule.value.origin, null)
      used_by                        = try(reverse(sort(rule.value.used_by)), null)

      dynamic "match_address_prefix" {
        for_each = try(rule.value.match_address_prefix, {})

        content {
          prefix = try(match_address_prefix.value.prefix, match_address_prefix.key)
          exact  = try(match_address_prefix.value.exact, true)
        }
      }
    }
  }

}
