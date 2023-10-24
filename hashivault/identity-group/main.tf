resource "vault_identity_group" "main" {
  external_member_entity_ids = var.external_member_entity_ids
  external_member_group_ids  = var.external_member_group_ids
  external_policies          = var.external_policies
  member_entity_ids          = var.member_entity_ids
  member_group_ids           = var.member_group_ids
  metadata                   = var.metadata
  name                       = var.name
  namespace                  = var.namespace
  policies                   = var.policies
  type                       = var.type
}

module "vault_identity_group_alias" {
  source = "../identity-group-alias"

  for_each = var.group_aliases

  canonical_id   = vault_identity_group.main.id
  mount_accessor = each.value.mount_accessor
  name           = each.key
  namespace      = try(each.value.namespace, var.namespace, null)
}
