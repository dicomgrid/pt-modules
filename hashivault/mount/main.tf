resource "vault_mount" "kvv2" {
  count = var.kvv2_enabled ? 1 : 0
  allowed_managed_keys = var.allowed_managed_keys
  description          = var.description
  namespace            = var.namespace
  options              = { version = "2" }
  path                 = var.path
  type                 = "kv"
}

resource "vault_kv_secret_backend_v2" "kvv2_backend" {
  count = var.kvv2_enabled ? 1 : 0
  cas_required         = var.cas_required
  delete_version_after = var.delete_version_after
  max_versions         = var.max_versions
  mount                = vault_mount.main.path
  namespace            = var.namespace
}

resource "vault_mount" "ssh" {
  count = var.ssh_enabled ? 1 : 0
  type      = "ssh"
  namespace = var.namespace
  path      = var.path
}

resource "vault_ssh_secret_backend_ca" "ssh_backend" {
  count = var.ssh_enabled ? 1 : 0
  backend   = vault_mount.main.path
  namespace = var.namespace
  generate_signing_key = var.generate_signing_key
}
