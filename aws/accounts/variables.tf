locals {
  # Get account info from data block
  ou = data.aws_organizations_organizational_units.main.children[*]
  # Create a map of child OU names and IDs from the accounts variable
  ou_map = { for ou in local.ou : ou.name => ou.id }
  # Split var.base_email to be rejoined as local.email
  split_base_email = split("@", var.base_email)
  # Create email by combining the base email with the account name
  email = "${local.split_base_email[0]}+${var.name}@${local.split_base_email[1]}"
  tags = merge({
    Billing     = var.billing
    Email       = local.email
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }, var.tags)
}

variable "base_email" { default = "aws@intelerad.com" }
variable "close_on_deletion" { default = false }
variable "email" { default = null }
variable "name" {}
variable "ou_name" {}
variable "role" { default = "cross_account_admin" }

## Tags ##
variable "billing" {}
variable "environment" {}
variable "owner" {}
variable "tags" { default = {} }
