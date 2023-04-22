locals {
    kms_policies = {
        shared_cluster = data.aws_iam_policy_document.shared_cluster.json
    }
    kms_policy = local.kms_policies[var.kms_policy]
}
variable "account_id" {}
variable "description" {}
variable "deletion_window_in_days" {}
variable "kms_alias" { default = null }
variable "kms_policy" { default = "shared_cluster" }
variable "kms_policy_enabled" { default = false }

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