# Basic configuration with our variables

variable "client_code" {
  default = "mso"
}
variable "linux_time_zone" {
  default = ""
}
variable "win_time_zone" {
  default = ""
}

variable "os" {}

variable "dc" {} # For MSO Deploys use: "ATL2", "NAS6", "NAS1", or "LAB-DC"

variable "dc_label" {
  default = ""
}
variable "host_cluster" {
  default = ""
}
variable "ds_cluster" {
  default = ""
}
variable "port_group" {
  default = "" # This should be "be" for Backend or "fe" for Frontend
}
variable "template" {
  default = ""
}
variable "is_windows_image" {
  default = false
}
variable "win_local_adminpass" {
  default = ""
}
variable "win_domain" {
  default = ""
}
variable "domain_admin_user" {
  default   = ""
  sensitive = true
}
variable "domain_admin_pw" {
  default   = ""
  sensitive = true
}
variable "run_once" {
  description = "List of Comamnd to run during first logon (Automatic login set to 1)."
  type        = list(any)
  default     = []
}
variable "server_ip" {
  default = ""
}
variable "server_netmask" {
  default = ""
}
variable "server_gateway" {
  default = ""
}
variable "server_dns" {
  default = ""
}
variable "server_name" { # mod, mdb, rig, clweb, etc.
  default = ""
}
variable "server_cpu" {
  default = "2"
}
variable "server_memory" {
  default = "2"
}
variable "server_disks" {
  type = list(any)
  default = [
    { size = 1 },  # boot
    { size = 8 },  # swap
    { size = 16 }, # /
    { size = 16 }, # /var
  ]
}
variable "server_disks_additional_count" {
  default = 0
}
variable "server_disks_additional_size" {
  default = 1
}
#variable "dc_map" {
#  type = map
#  default = {
#    "atl" = "ATL"
#    "nas" = "NAS6"
#    "nas1" = "NAS1"
#    "lab"  = "LAB-DC"
#  }
#}