data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_distributed_virtual_switch" "vds" {
  name          = var.vds
  datacenter_id = data.vsphere_datacenter.datacenter.id
}