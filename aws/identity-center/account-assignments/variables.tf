locals {
  # Convert tuple to uniquely keyed dictionary
  account_bindings_dict = {
    for binding in var.account_bindings_tuple : "${binding.group}.${binding.permset}" => binding
  }
}

variable "account_name" {}
variable "account_bindings_tuple" {}
variable "accounts_id_map" {}
variable "sso_identity_store_id" {}
variable "sso_instance_arn" {}
variable "groups_map" {}
variable "permsets_map" {}