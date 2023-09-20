resource "vault_mount" "kvv1" {
  path        = "kvv1"
  type        = "kv"
  options     = { version = "1" }
  description = "KV Version 1 secret engine mount"
}

resource "vault_mount" "kvv2" {
  allowed_managed_keys = var.allowed_managed_keys
  description          = var.description
  namespace            = var.namespace
  options              = { version = "2" }
  path                 = var.path
  type                 = "kv"
}

resource "vault_kv_secret_backend_v2" "kvv2_backend" {
  cas_required         = var.cas_required
  delete_version_after = var.delete_version_after
  max_versions         = var.max_versions
  mount                = vault_mount.kvv2.path
  namespace            = var.namespace
}
