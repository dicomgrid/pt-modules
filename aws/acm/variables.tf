locals {
  tags_base = {
    Billing     = var.billing
    CodeManaged = var.code_managed
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }
  tags = merge(local.tags_base, var.tags_extra)
}

variable "domain_name" {}
variable "subject_alternative_names" {
  default = []
  type    = list(string)
}
variable "validation_record_ttl" {
  default = 60
  type    = number
}
variable "allow_validation_record_overwrite" {
  default = true
}
variable "validation_method" {
  default = "DNS"
}

variable "wildcard" {
  default = false
}

# Tags
variable "billing" {}
variable "code_managed" {}
variable "creator" {}
variable "environment" {}
variable "name" {}
variable "owner" {}
variable "tags_extra" {
  description = "Addtional tags to merge with standard tags"
  default = {}
}