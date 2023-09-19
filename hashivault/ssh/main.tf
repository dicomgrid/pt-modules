resource "vault_mount" "ssh" {
  type      = "ssh"
  namespace = var.namespace
  path      = var.path
}

resource "vault_ssh_secret_backend_ca" "ssh_backend" {
  backend   = vault_mount.ssh.path
  namespace = var.namespace
  generate_signing_key = var.generate_signing_key
}
