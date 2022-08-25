# Configure vlan and network params

#### Back End Servers PORT CONFIG
# Create port be with vlan
resource "vsphere_distributed_port_group" "be" {
  name                = var.port_group_be
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dc.id
  vlan_id             = var.vlan_be
  allow_promiscuous   = true
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

#### Front End Servers PORT CONFIG
# Create port fe with vlan
resource "vsphere_distributed_port_group" "fe" {
  name                = var.port_group_fe
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dc.id
  vlan_id             = var.vlan_fe
  allow_promiscuous   = true
  provisioner "local-exec" {
    command = "sleep 10"
  }
}