resource "google_filestore_instance" "main" {
  name     = var.name
  location = var.location
  tier     = var.tier
  labels   = var.labels

  file_shares {
    capacity_gb = var.capacity_gb
    name        = var.name

    nfs_export_options {
      ip_ranges   = var.ip_ranges
      access_mode = var.access_mode
    }
  }

  networks {
    network      = var.network
    modes        = var.modes
    connect_mode = var.connect_mode
  }
}

