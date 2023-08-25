variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type    = string
  default = ""
}

variable "availability_zone" {
  type    = string
  default = ""
}

variable "customer_owned_ipv4_pool" {
  type    = string
  default = ""
}

variable "enable_dns64" {
  type    = string
  default = ""
}

variable "enable_resource_name_dns_aaaa_record_on_launch" {
  type    = string
  default = ""
}

variable "enable_resource_name_dns_a_record_on_launch" {
  type    = string
  default = ""
}

variable "ipv6_cidr_block" {
  type    = string
  default = ""
}

variable "ipv6_native" {
  type    = string
  default = ""
}

variable "map_customer_owned_ip_on_launch" {
  type    = string
  default = ""
}

variable "map_public_ip_on_launch" {
  type    = string
  default = ""
}

variable "outpost_arn" {
  type    = string
  default = ""
}

variable "private_dns_hostname_type_on_launch" {
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
