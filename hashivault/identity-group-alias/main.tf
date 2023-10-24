resource "vault_identity_group_alias" "main" {
  name           = var.name
  namespace      = var.namespace
  mount_accessor = var.mount_accessor
  canonical_id   = var.canonical_id
}
