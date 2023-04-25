locals {
  lifecycle_rules = var.lifecycle_rules
}
variable "acl" { default = "private" }
variable "directories" { default = {} }
variable "kms_key_alias" { default = null }
variable "lifecycle_rules" { default = {} }
variable "logging_acl" { default = "log-delivery-write" }
variable "logging_enabled" { default = false }
variable "logging_expiration" { default = 90 }
variable "object_ownership" { default = "BucketOwnerPreferred" }
variable "sse_enabled" { default = false }
variable "sse_algorithm" { default = "aws:kms" }
variable "tags" {}
# variable "tfstate_lifecycle_status" { default = "Disabled" }
variable "versioning_status" { default = "Disabled" }