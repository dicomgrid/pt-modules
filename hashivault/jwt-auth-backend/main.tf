resource "vault_jwt_auth_backend" "main" {
  bound_issuer           = var.bound_issuer
  default_role           = var.default_role
  description            = var.description
  disable_remount        = var.disable_remount
  jwks_ca_pem            = var.jwks_ca_pem
  jwks_url               = var.jwks_url
  jwt_supported_algs     = var.jwt_supported_algs
  jwt_validation_pubkeys = var.jwt_validation_pubkeys
  local                  = var.local
  namespace              = var.namespace
  namespace_in_state     = var.namespace_in_state
  oidc_client_id         = var.oidc_client_id
  oidc_client_secret     = var.oidc_client_secret
  oidc_discovery_ca_pem  = var.oidc_discovery_ca_pem
  oidc_discovery_url     = var.oidc_discovery_url
  oidc_response_mode     = var.oidc_response_mode
  path                   = var.path
  provider_config        = var.provider_config
  type                   = var.type
  tune {
    allowed_response_headers     = var.allowed_response_headers
    audit_non_hmac_request_keys  = var.audit_non_hmac_request_keys
    audit_non_hmac_response_keys = var.audit_non_hmac_response_keys
    default_lease_ttl            = var.default_lease_ttl
    listing_visibility           = var.listing_visibility
    max_lease_ttl                = var.max_lease_ttl
    passthrough_request_headers  = var.passthrough_request_headers
    token_type                   = var.token_type
  }
}


module "role" {
  source = "../jwt-auth-backend-role"

  for_each = var.roles

  allowed_redirect_uris   = try(each.value.allowed_redirect_uris, null)
  backend                 = vault_jwt_auth_backend.main.path
  bound_audiences         = try(each.value.bound_audiences, null)
  bound_claims            = try(each.value.bound_claims, null)
  bound_claims_type       = try(each.value.bound_claims_type, null)
  bound_subject           = try(each.value.bound_subject, null)
  claim_mappings          = try(each.value.claim_mappings, null)
  clock_skew_leeway       = try(each.value.clock_skew_leeway, null)
  expiration_leeway       = try(each.value.expiration_leeway, null)
  groups_claim            = try(each.value.groups_claim, null)
  max_age                 = try(each.value.max_age, null)
  namespace               = try(each.value.namespace, var.namespace, null)
  not_before_leeway       = try(each.value.not_before_leeway, null)
  oidc_scopes             = try(each.value.oidc_scopes, null)
  role_name               = try(each.value.role_name, each.key, null)
  role_type               = try(each.value.role_type, null)
  token_bound_cidrs       = try(each.value.token_bound_cidrs, null)
  token_explicit_max_ttl  = try(each.value.token_explicit_max_ttl, null)
  token_max_ttl           = try(each.value.token_max_ttl, null)
  token_no_default_policy = try(each.value.token_no_default_policy, null)
  token_num_uses          = try(each.value.token_num_uses, null)
  token_period            = try(each.value.token_period, null)
  token_policies          = try(each.value.token_policies, null)
  token_ttl               = try(each.value.token_ttl, null)
  token_type              = try(each.value.token_type, null)
  user_claim              = each.value.user_claim
  user_claim_json_pointer = try(each.value.user_claim_json_pointer, null)
  verbose_oidc_logging    = try(each.value.verbose_oidc_logging, null)
}
