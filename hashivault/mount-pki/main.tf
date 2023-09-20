resource "vault_mount" "main" {
  path                      = "pki"
  type                      = "pki"
  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_role" "main" {
  backend          = vault_mount.main.path
  name             = var.name
  ttl              = var.ttl
  allow_ip_sans    = var.allow_ip_sans
  key_type         = var.key_type
  key_bits         = var.key_bits
  allowed_domains  = var.allowed_domains
  allow_subdomains = var.allow_subdomains
}
