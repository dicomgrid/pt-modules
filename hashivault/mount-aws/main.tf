
resource "vault_aws_secret_backend" "aws" {
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
  backend         = vault_aws_secret_backend.aws.path
  name            = var.name
  credential_type = var.credential_type
  role_arns       = var.role_arns
}
