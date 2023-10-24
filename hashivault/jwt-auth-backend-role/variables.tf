variable "allowed_redirect_uris" { default = null }
variable "backend" { default = null }
variable "bound_audiences" { default = null }
variable "bound_claims_type" { default = null }
variable "bound_claims" { default = {} }
variable "bound_subject" { default = null }
variable "claim_mappings" { default = null }
variable "clock_skew_leeway" { default = null }
variable "expiration_leeway" { default = null }
variable "groups_claim" { default = null }
variable "max_age" { default = null }
variable "namespace" { default = null }
variable "not_before_leeway" { default = null }
variable "oidc_scopes" { default = null }
variable "role_name" {}
variable "role_type" { default = null }
variable "token_bound_cidrs" { default = [] }
variable "token_explicit_max_ttl" { default = null }
variable "token_max_ttl" { default = null }
variable "token_no_default_policy" { default = null }
variable "token_num_uses" { default = null }
variable "token_period" { default = null }
variable "token_policies" { default = [] }
variable "token_ttl" { default = null }
variable "token_type" { default = null }
variable "user_claim_json_pointer" { default = null }
variable "user_claim" {}
variable "verbose_oidc_logging" { default = null }
