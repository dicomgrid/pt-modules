variable "access_key" { default = "" }
variable "secret_key" { default = "" }
variable "region" { default = "" }
variable "default_lease_ttl_seconds" { default = 3600 }
variable "description" { default = "" }
variable "max_lease_ttl_seconds" { default = 7200 }
variable "namespace" { default = null }
variable "path" { default = "aws" }

variable "roles" {
  type = list(object({
    credential_type = string
    name            = string
    role_arns       = list(string)
    namespace       = string
    policy_document = string
  }))
}
