resource "vsphere_distributed_port_group" "pg" {
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.vds.id

  name                            = var.name
  active_uplinks                  = var.active_uplinks != null ? var.active_uplinks : null
  standby_uplinks                 = var.standby_uplinks != null ? var.standby_uplinks : null
  vlan_id                         = var.vlan_id != null ? var.vlan_id : null
  type                            = var.type
  block_override_allowed          = var.block_override_allowed
  port_config_reset_at_disconnect = var.port_config_reset_at_disconnect
  allow_forged_transmits          = var.allow_forged_transmits
  allow_mac_changes               = var.allow_mac_changes
  allow_promiscuous               = var.allow_promiscuous
  auto_expand                     = var.auto_expand

  dynamic "vlan_range" {
    for_each = var.min_vlan != null ? [true] : []
    content {
      min_vlan = var.min_vlan
      max_vlan = var.max_vlan
    }
  }
}