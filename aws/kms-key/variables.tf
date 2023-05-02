locals {
  account_id = var.account_id == null ? data.aws_caller_identity.current.account_id : var.account_id
  region     = var.region == null ? data.aws_region.current.name : var.region
  kms_policies = {
    shared_cluster = data.aws_iam_policy_document.shared_cluster.json
    ebs            = data.aws_iam_policy_document.ebs.json
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