resource "vsphere_datastore_cluster" "datastore_cluster" {
  name                      = var.name
  datacenter_id             = data.vsphere_datacenter.datacenter.id
  sdrs_enabled              = var.sdrs_enabled
  sdrs_automation_level     = var.sdrs_automation_level
  sdrs_io_latency_threshold = var.sdrs_io_latency_threshold

  lifecycle {
    prevent_destroy = true
  }
}