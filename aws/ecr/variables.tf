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
variable "billing" {}
variable "code_managed" {}
variable "creator" {}
variable "environment" {}
variable "name" {}
variable "owner" {}
variable "tags_extra" { default = {} }
