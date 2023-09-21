resource "vault_auth_backend" "main" {
  type = "kubernetes"
  path = var.path
}

resource "vault_kubernetes_auth_backend_role" "main" {
  backend                          = vault_auth_backend.main.path
  role_name                        = var.role_name
  bound_service_account_names      = var.bound_service_account_names
  bound_service_account_namespaces = var.bound_service_account_namespaces
  token_ttl                        = var.token_ttl
  token_policies                   = var.token_policies
  audience                         = var.audience
}

resource "vault_kubernetes_auth_backend_config" "main" {
  backend                = vault_auth_backend.main.path
  kubernetes_host        = var.kubernetes_host
  kubernetes_ca_cert     = var.kubernetes_ca_cert
  token_reviewer_jwt     = var.token_reviewer_jwt
  issuer                 = var.issuer
  disable_iss_validation = var.disable_iss_validation
}
