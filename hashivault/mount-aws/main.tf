
resource "vault_aws_secret_backend" "main" {
  access_key                = var.access_key
  secret_key                = var.secret_key
  region                    = var.region
  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  description               = var.description
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds
  namespace                 = var.namespace
  path                      = var.path
}

resource "vault_aws_secret_backend_role" "main" {
  for_each = var.roles

  backend         = vault_aws_secret_backend.main.path
  name            = roles.value["name"]
  credential_type = roles.value["credential_type"]
  role_arns       = roles.value["role_arns"]
  policy_document = roles.value["policy_document"]
}
