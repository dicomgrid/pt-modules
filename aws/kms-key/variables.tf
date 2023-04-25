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
variable "tags" {}