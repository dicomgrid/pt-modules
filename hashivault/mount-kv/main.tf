resource "vault_mount" "kvv1" {
  path        = var.kvv1_path
  type        = "kv"
  description = "${var.namespace} kv secret engine mount"
  namespace   = var.namespace
  options     = { version = "1" }
}
resource "vault_mount" "kvv2" {
  allowed_managed_keys = var.allowed_managed_keys
  namespace            = var.namespace
  description          = "${var.namespace} kvv2 secret engine mount"
  options              = { version = "2" }
  path                 = var.kvv2_path
  type                 = "kv"
}

resource "vault_kv_secret_backend_v2" "kvv2_backend" {
  cas_required         = var.cas_required
  delete_version_after = var.delete_version_after
  max_versions         = var.max_versions
  mount                = vault_mount.kvv2.path
  namespace            = var.namespace
}
