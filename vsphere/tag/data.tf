data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_tag_category" "category_client_code" {
  name = var.tag_category
}