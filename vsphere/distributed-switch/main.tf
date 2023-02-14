resource "vsphere_distributed_virtual_switch" "vds" {
  name                             = var.name
  datacenter_id                    = data.vsphere_datacenter.datacenter.id
  uplinks                          = var.uplinks
  network_resource_control_enabled = var.network_resource_control_enabled
  ignore_other_pvlan_mappings      = var.ignore_other_pvlan_mappings
  netflow_sampling_rate            = var.netflow_sampling_rate
  max_mtu = var.max_mtu

  lifecycle {
    ignore_changes = [
      host
    ]
    prevent_destroy = true
  }
}