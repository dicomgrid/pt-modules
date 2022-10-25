data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  count         = var.datastore != null ? 1 : 0
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore_cluster" "datastore_cluster" {
  count         = var.datastore_cluster != null ? 1 : 0
  name          = var.datastore_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


data "vsphere_compute_cluster" "cluster" {
  name          = var.compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "port_group" {
  name          = var.port_group
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "guest_template" {
  name          = lookup(var.guest_template_codes, var.os)
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_tag_category" "category_client_code" {
  name = "client_code"
}

data "vsphere_tag_category" "category_role" {
  name = "role"
}

data "vsphere_tag_category" "category_creator" {
  name = "creator"
}

data "vsphere_tag" "tag_client_code" {
  name        = var.client_code
  category_id = data.vsphere_tag_category.category_client_code.id
}

data "vsphere_tag" "tag_type" {
  name        = var.role
  category_id = data.vsphere_tag_category.category_role.id
}

data "vsphere_tag" "tag_creator" {
  name        = "terraform"
  category_id = data.vsphere_tag_category.category_creator.id
}