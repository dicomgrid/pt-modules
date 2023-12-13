
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
  for_each        = { for k in var.roles : k.name => k }
  backend         = vault_aws_secret_backend.main.path
  name            = each.value.name
  credential_type = each.value.credential_type
  policy_document = each.value.policy_document
  namespace       = each.value.namespace
  role_arns       = each.value.role_arns
}
