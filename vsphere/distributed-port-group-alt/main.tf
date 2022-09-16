resource "vsphere_distributed_port_group" "main" {
  name                            = var.name
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dc.id
  vlan_id                         = var.vlan_id
  allow_promiscuous               = true
  provisioner "local-exec" {
    command = "sleep 10"
  }
}