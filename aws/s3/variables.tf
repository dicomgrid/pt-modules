locals {
  lifecycle_rules = var.lifecycle_rules
  object_lock_period = var.object_lock_period
  bucket_policy = var.bucket_policy
}

variable "acl" { default = "private" }
variable "bucket_key_enabled" { default = true }
variable "bucket_policy_enabled" { default = false }
variable "bucket_policy" { default = "" }
variable "directories" { default = {} }
variable "kms_cmk_alias" { default = null }
variable "lifecycle_rules" { default = {} }
variable "object_lock_enabled" { default = false }
variable "object_lock_period" {default = {} }
variable "logging_acl" { default = "log-delivery-write" }
variable "logging_enabled" { default = false }
variable "logging_expiration" { default = 90 }
variable "object_ownership" { default = "BucketOwnerPreferred" }
variable "sse_enabled" { default = false }
variable "sse_algorithm" { default = "aws:kms" }
variable "versioning_status" { default = "Disabled" }

# Tags
locals {
  default_tags = {
    CodeManaged              = var.code_managed
    Compliance               = var.compliance
    OneTime                  = var.onetime
    aws-migration-project-id = var.aws_project_id
    map-migrated             = var.map_migrated
  }
  tags = merge(local.default_tags, var.tags)
}
variable "tags" {}

variable "aws_project_id" { default = "null" }
variable "code_managed" { default = "true" }
variable "compliance" { default = "null" }
variable "map_migrated" { default = "null" }
variable "onetime" { default = "null" }