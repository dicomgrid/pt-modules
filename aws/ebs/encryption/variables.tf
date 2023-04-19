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

variable "enabled" { default = true }
variable "tags_extra" { default = {} }