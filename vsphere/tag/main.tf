resource "vsphere_tag" "tag_client_code" {
  name        = var.name
  category_id = data.vsphere_tag_category.category_client_code.id
  description = var.description
}