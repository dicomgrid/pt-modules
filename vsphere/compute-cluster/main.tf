resource "vsphere_compute_cluster" "compute_cluster" {
  name                    = var.name
  datacenter_id           = data.vsphere_datacenter.datacenter.id
  drs_enabled             = var.drs_enabled
  drs_automation_level    = var.drs_automation_level
  drs_migration_threshold = var.drs_migration_threshold
  ha_enabled              = var.ha_enabled

  lifecycle {
    prevent_destroy = true
  }
}