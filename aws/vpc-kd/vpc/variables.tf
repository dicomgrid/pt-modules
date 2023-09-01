variable "cidr_block" {
  type    = string
  default = ""
}

variable "instance_tenancy" {
  type    = string
  default = ""
}

variable "ipv4_ipam_pool_id" {
  type    = string
  default = ""
}

variable "ipv4_netmask_length" {
  type    = string
  default = ""
}

variable "ipv6_cidr_block" {
  type    = string
  default = ""
}

variable "ipv6_ipam_pool_id" {
  type    = string
  default = ""
}

variable "ipv6_netmask_length" {
  type    = string
  default = ""
}

variable "ipv6_cidr_block_network_border_group" {
  type    = string
  default = ""
}

variable "enable_dns_support" {
  type    = string
  default = ""
}

variable "enable_network_address_usage_metrics" {
  type    = string
  default = ""
}

variable "enable_dns_hostnames" {
  type    = string
  default = ""
}

variable "enable_classiclink" {
  type    = string
  default = ""
}

variable "enable_classiclink_dns_support" {
  type    = string
  default = ""
}

variable "assign_generated_ipv6_cidr_block" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Automation"
    OWNER     = "Automation"
    OWNER2    = "Automation"
  }
}
