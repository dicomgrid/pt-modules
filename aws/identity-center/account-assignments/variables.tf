locals {
  # Get account info from data block
  accounts_data = data.aws_organizations_organization.main.accounts
  # Create a map of account names and IDs from the accounts variable
  accounts_id_map = { for account in local.accounts_data : account.name => account.id }
  # Convert tuple to uniquely keyed dictionary
  account_bindings_dict = {
    for binding in var.account_bindings_tuple : "${binding.group}.${binding.permset}" => binding
  }
  # Get group data to use as lookup for group details
  group_data = data.aws_identitystore_group.group
  # Get permset data to use as lookup for permset details
  permset_data = data.aws_ssoadmin_permission_set.permset
}

variable "account_name" {}
variable "account_bindings_tuple" {}