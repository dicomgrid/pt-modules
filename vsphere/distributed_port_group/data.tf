#### NETWORK Data Extraction from VSphere

# Define priamry datacenter
data "vsphere_datacenter" "dc" {
  name = var.dc
}

# Extract data port vlan creation
data "vsphere_distributed_virtual_switch" "dc" {
  name          = var.dswitch
  datacenter_id = data.vsphere_datacenter.dc.id
}

