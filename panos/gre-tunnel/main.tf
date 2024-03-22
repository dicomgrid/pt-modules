resource "panos_tunnel_interface" "main" {
  count = try(var.tunnel_interface.create, true) ? 1 : 0

  name               = try(var.tunnel_interface.name, var.tunnel_interface)
  vsys               = try(var.tunnel_interface.vsys, "vsys1")
  comment            = try(var.tunnel_interface.comment, "Tunnel interface for GRE tunnel - ${var.name}")
  netflow_profile    = try(var.tunnel_interface.netflow_profile, null)
  static_ips         = try(var.tunnel_interface.static_ips, [])
  management_profile = try(var.tunnel_interface.management_profile, null)
  mtu                = try(var.tunnel_interface.mtu, null)

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_gre_tunnel" "main" {
  name                  = var.name
  interface             = var.interface
  local_address_value   = var.local_address
  peer_address          = var.peer_address
  tunnel_interface      = try(panos_tunnel_interface.main[0].name, var.tunnel_interface.name, var.tunnel_interface)
  ttl                   = var.ttl
  copy_tos              = var.copy_tos
  enable_keep_alive     = var.enable_keep_alive
  keep_alive_interval   = var.keep_alive_interval
  keep_alive_retry      = var.keep_alive_retry
  keep_alive_hold_timer = var.keep_alive_hold_timer
  disabled              = var.disabled

  lifecycle {
    create_before_destroy = true
  }
}
