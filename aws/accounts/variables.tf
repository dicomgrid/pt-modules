locals {
  # Get account info from data block
  ou = data.aws_organizations_organizational_units.main.children[*]
  # Create a map of child OU names and IDs from the accounts variable
  ou_map = { for ou in local.ou : ou.name => ou.id }
  # Translate account names in permsets.[permset]accounts to accounts IDs and create dictionary of all IDs 
  #permset_account_ids = { for name in keys(var.permsets) : name => [for account in var.permsets[name].accounts : local.account_map[account]] }
  #ou_ids = { for name in var.ou_name : name => local.ou_map[name] }
}


# Static Variables
variable "accounts" {
  type    = map(any)
  default = {}
}


# Input Variables
variable "name" {}
variable "role" {
  default = "cross_account_admin"
}
variable "ou_name" {}
variable "tags" {
  default = ""
}

