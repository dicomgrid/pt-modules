resource "vsphere_folder" "folder" {
  path          = "${var.parent_folder}/${var.client_code}"
  type          = var.folder_type
  datacenter_id = data.vsphere_datacenter.datacenter.id
}