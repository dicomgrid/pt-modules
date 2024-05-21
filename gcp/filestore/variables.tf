variable "access_mode" {}
variable "capacity_gb" { default = 100 }
variable "connect_mode" { default = "DIRECT_PEERING" }
variable "include_nfs_export_options" { default = true }
variable "ip_ranges" { default = [] }
variable "kms_key_name" { default = null }
variable "location" {}
variable "modes" { default = [] }
variable "name" {}
variable "network" {}
variable "share_name" {}
variable "tier" { default = "BASIC_SSD" }
