variable "acl" { default = "private" }
variable "kms_key_alias" { default = null }
variable "sse_enabled" { default = false }
variable "sse_algorithm" { default = "aws:kms" }
variable "versioning" { default = true }


# Tags
variable "billing" {}
variable "code_managed" {}
variable "creator" {}
variable "environment" {}
variable "name" {}
variable "owner" {}
variable "tags_extra" { default = {} }

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