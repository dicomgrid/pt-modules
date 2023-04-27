locals {
    account_id = var.account_id == null ? data.aws_caller_identity.current.account_id : var.account_id
    region = var.region == null ? data.aws_region.current.name : var.region
    kms_policies = {
        shared_cluster = data.aws_iam_policy_document.shared_cluster.json
        ebs = data.aws_iam_policy_document.ebs.json
    }
    kms_policy = var.kms_policy == null ? null : local.kms_policies[var.kms_policy]
}
variable "account_id" { default = null }
variable "description" {}
variable "deletion_window_in_days" {}
variable "ebs_kms_shared_account_roles" { default = null }
variable "kms_alias" { default = null }
variable "kms_policy" { default = null }
variable "region" { default = null }
variable "tags" {}