resource "vsphere_tag_category" "category" {
  name             = var.name
  description      = var.description
  cardinality      = var.cardinality
  associable_types = var.associable_types
}