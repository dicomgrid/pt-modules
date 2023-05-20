resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "auth_backend" {
  backend         = vault_auth_backend.approle.path
  role_name       = var.approle_name
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.auth_backend.role_name
}

resource "vault_approle_auth_backend_login" "login" {
  backend   = vault_auth_backend.approle.path
  role_id   = vault_approle_auth_backend_role.auth_backend.role_id
  secret_id = vault_approle_auth_backend_role_secret_id.id.secret_id
}