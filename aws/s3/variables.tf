variable "acl" { default = "private" }
variable "kms_key_alias" { default = null }
variable "logging_acl" { default = "log-delivery-write" }
variable "logging_enabled" { default = false }
variable "logging_expiration" { default = 90 }
variable "object_ownership" { default = "BucketOwnerPreferred" }
variable "sse_enabled" { default = false }
variable "sse_algorithm" { default = "aws:kms" }
variable "tfstate_lifecycle_status" { default = "Disabled" }
variable "versioning_status" { default = "Disabled" }

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