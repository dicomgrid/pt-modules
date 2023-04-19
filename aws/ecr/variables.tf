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

variable "cross_account_access" {
  default = false
}

variable "encryption_type" {
  default = "AES256"
}

variable "image_tag_mutability" {
  default = "MUTABLE"
}

variable "lifecycle_policy" { default = null }

variable "scan_on_push" {
  default = true
}

# Tags
variable "billing" {}
variable "code_managed" {}
variable "creator" {}
variable "environment" {}
variable "name" {}
variable "owner" {}
variable "tags_extra" { default = {} }
