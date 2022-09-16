resource "vsphere_tag" "tag_client_code" {
  name        = var.client_code
  category_id = data.vsphere_tag_category.category_client_code.id
}