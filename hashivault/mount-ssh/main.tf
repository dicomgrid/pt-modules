resource "vault_mount" "main" {
  type      = "ssh"
  namespace = var.namespace
  path      = var.path
}

resource "vault_ssh_secret_backend_ca" "main" {
  backend              = vault_mount.main.path
  namespace            = var.namespace
  generate_signing_key = var.generate_signing_key
}
