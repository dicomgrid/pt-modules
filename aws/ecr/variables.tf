locals {
  permissions_read_write = merge(
    length(var.push_roles) > 0 ? { AWS = var.push_roles } : {},
    length(var.push_service_identifiers) > 0 ? { Service = var.push_service_identifiers } : {},
  )
  permissions_read_only = merge(
    length(var.pull_roles) > 0 ? { AWS = var.pull_roles } : {},
    length(var.pull_service_identifiers) > 0 ? { Service = var.pull_service_identifiers } : {},
  )
  permissions_create = length(local.permissions_read_write) > 0 || length(local.permissions_read_only) > 0 ? true : false

  lifecycle_policy = var.lifecycle_policy == "default" ? var.lifecycle_policy_default : var.lifecycle_policy
}

variable "cross_account_access" {
  default = false
}

variable "encryption_type" {
  default = "AES256"
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE."
  type        = string
  default     = "MUTABLE"
}

variable "kms_key" {
  description = "ARN of the KMS to use when encryption type is KMS"
  type        = string
  default     = null
}

variable "lifecycle_policy" { default = "default" }
variable "lifecycle_policy_enable" { default = true }

variable "push_roles" {
  description = "Role ARN's that have read/write access"
  type        = list(string)
  default     = []
}

variable "push_service_identifiers" {
  description = "Service identifiers that have read/write access"
  type        = list(string)
  default     = []
}

variable "pull_roles" {
  description = "Role ARN's that have read-only access"
  type        = list(string)
  default     = []
}

variable "pull_service_identifiers" {
  description = "Service identifiers that have read-only access"
  type        = list(string)
  default     = []
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = string
  default     = true
}

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