#### RETRIEVE DATA INFORMATION ON VCENTER ####

data "vsphere_datacenter" "dc" {
  name = var.dc
}

# If you haven't resource pool, put "Resources" after cluster name
data "vsphere_resource_pool" "pool" {
  name          = "${var.host_cluster}/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve datastore cluster information on vsphere
### COMMENTING OUT UNTIL DS-CLUSTER IMPLEMENTATION ###
#data "vsphere_datastore_cluster" "datastore" {
#  name          = var.ds_cluster
#  datacenter_id = data.vsphere_datacenter.dc.id
#}

data "vsphere_datastore" "datastore" {
  name          = var.ds_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve network information on vsphere
data "vsphere_network" "network" {
  name          = var.port_group # End format should be "mso_be". This is dependent on existing port group matching this name.
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve template information on vsphere
data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}
