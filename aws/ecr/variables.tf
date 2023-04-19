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

variable "application" {
  default = ""
}

variable "billing" {
  default = ""
}

variable "creator" {
  default = "Terraform"
}

variable "cross_account_access" {
  default = false
}

variable "encryption_type" {
  default = "AES256"
}

variable "environment" {
  default = "production"
}

variable "image_tag_mutability" {
  default = "MUTABLE"
}

variable "name" {}

variable "owner" {
  default = "DevOps"
}

variable "scan_on_push" {
  default = true
}

variable "tags_extra" { default = {} }
