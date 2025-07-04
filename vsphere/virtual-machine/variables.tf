variable "guest_name" {}

variable "datacenter" {}

variable "datastore" {
  default = null
}

variable "datastore_cluster" {
  default = null
}

variable "server_code" {
  default = ""
}

variable "compute_cluster" {}

variable "port_group" {}

variable "os" {}

variable "role" {
  default = ""
}

variable "resource_group" {}

variable "guest_template_codes" {
  type = map(any)
  default = {
    "linux"       = "rocky8-template"
    "rocky8"      = "rocky8-template"
    "centos7"     = "centos7-template"
    "windows"     = "windows2016-template"
    "windows2016" = "windows2016-template"
    "windows2019" = "windows2019-template"
    "windows2022" = "windows2022-template"
  }
}

variable "client_code" {}

variable "client_architecture" {}

variable "parent_folder" {
  default = "ims"
}

variable "guest_vcpu" {}

variable "guest_memory" {}

variable "adapter_type" {
  default = "vmxnet3"
}

variable "guest_ipv4_ip" {}

variable "guest_ipv4_netmask" {}

variable "guest_ipv4_gateway" {}

variable "guest_dns_servers" {
  type = map(any)
  default = {
    "atl2" = ["10.255.0.22", "10.255.0.21", ]
    "nas6" = ["10.0.0.22", "10.0.0.21", ]
    "nas1" = ["10.0.8.2", "10.0.8.3", ]
    "mna"  = ["10.0.8.2", "10.0.8.3", ]
    "dfw"  = ["10.125.80.22", "10.125.80.21", ]
  }
}

variable "guest_dns_suffix" {
  default = ""
}

###
variable "local_password" {
  sensitive = true
}

variable "run_once" {
  description = "List of Comamnd to run during first logon (Automatic login set to 1)."
  type        = list(any)
  default     = []
}

variable "guest_disks" {
  type = list(any)
  default = [
    { size = 16 }, # boot and /
    { size = 15 }, # swap
    { size = 16 }, # /var
  ]
}

variable "guest_disks_scsi2" {
  default = []
}

variable "guest_disks_scsi3" {
  default = []
}

variable "client_time_zone" {}

variable "linux_time_zones" {
  type = map(any)
  default = {
    "est" = "America/New_York"
    "cst" = "America/Chicago"
    "mst" = "America/Denver"
    "pst" = "America/Los_Angeles"
  }
}

variable "win_time_zones" {
  type = map(any)
  default = {
    "est"                 = "035"
    "cst"                 = "020"
    "mst"                 = "010"
    "pst"                 = "004"
    "America/New_York"    = "035"
    "America/Chicago"     = "020"
    "America/Denver"      = "010"
    "America/Los_Angeles" = "004"
  }
}
