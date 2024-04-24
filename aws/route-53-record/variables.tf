variable "name" {}

variable "private_zone" {
  default = false
}

variable "records" {}

variable "ttl" {
  default = "60"
}

variable "type" {}

variable "zone_name" {
  default = "ambrahealth.com"
}