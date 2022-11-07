locals {
  # Get account info from data block
  ou                  = data.aws_organizations_organizational_units.main.children[*]
  # Create a map of child OU names and IDs from the accounts variable
  ou_map               = { for ou in local.ou : ou.name => ou.id }
  # Translate account names in permsets.[permset]accounts to accounts IDs and create dictionary of all IDs 
  #permset_account_ids = { for name in keys(var.permsets) : name => [for account in var.permsets[name].accounts : local.account_map[account]] }
  ou_ids = { for name in ou_name : name =>  local.ou_map[name] }
}


# Static Variables
variable "access_billing" {
  default     = "ALLOW"
  type        = string
  description = "If set to ALLOW, the new account enables IAM users to access account billing information."
}

variable "accounts" {
  type    = map(any)
  default = {}
}

variable "enabled" {
  default     = true
  type        = string
  description = "Set to false to prevent the module from creating anything."
}

variable "parent_id_map" {
  default = {
    ambra_health       = "ou-53vz-yludznnj"
    ambra_dev          = "ou-53vz-gwvk7qhd"
    ambra_prod         = "ou-53vz-8erqn478"
    ambra_uat          = "ou-53vz-n7ekg6ry"
    ambra_dev_storage  = "ou-53vz-l5l0aoz8"
    ambra_uat_storage  = "ou-53vz-aypewb4f"
    ambra_prod_storage = "ou-53vz-hedgvb2o"

  }
}


# Input Variables
variable "name" {}
variable "email" {}
variable "role" {}
variable "ou_name" {}
variable "tags" {}

