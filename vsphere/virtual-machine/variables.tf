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
  default = "I000-Intelerad"
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
  }
}

variable "guest_dns_suffix" {
  default = ""
}

###
variable "win_local_admin_pass" {
  sensitive = true
}

variable "win_domain" {
  default = "radiustoday.com"
}

variable "domain_admin_user" {}

variable "domain_admin_pass" {
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
    { size = 1 },  # boot
    { size = 8 },  # swap
    { size = 16 }, # /
    { size = 16 }, # /var
  ]
}

variable "guest_disks_additional_count" {
  default = 0
}

variable "guest_disks_additional_size" {
  default = 1
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
    "est" = "035"
    "cst" = "020"
    "mst" = "010"
    "pst" = "004"
  }
}