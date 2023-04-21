locals {
  # Get account info from data block
  accounts_data = data.aws_organizations_organization.main.accounts
  # Create a map of account names and IDs from the accounts variable
  accounts_id_map = { for account in local.accounts_data : account.name => account.id }
  # List of all account names that are active
  accounts_all = [for account in local.accounts_data : account.name if account.status == "ACTIVE"]
  # Lists of all account names for ambra storage accounts
  accounts_ambra_storage_dev = [for account in local.accounts_all : account if length(regexall("Storage.*_Dev", account)) > 0]
  accounts_ambra_storage_prod = [for account in local.accounts_all : account if length(regexall("storage.*_prod", account)) > 0]
  accounts_ambra_storage_uat = [for account in local.accounts_all : account if length(regexall("Storage.*_UAT", account)) > 0]
  # Lists of all account names for platform accounts
  accounts_platform= [for account in local.accounts_all : account if length(regexall("ims-platform*", account)) > 0]
}