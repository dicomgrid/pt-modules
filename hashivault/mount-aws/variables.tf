variable "access_key" { default = "" }
variable "secret_key" { default = "" }
variable "region" { default = "" }
# variable "credential_type" { default = "assumed_role" }
variable "default_lease_ttl_seconds" { default = 3600 }
variable "description" { default = "" }
variable "max_lease_ttl_seconds" { default = 7200 }
# variable "name" { default = "" }
variable "namespace" { default = null }
variable "path" { default = "aws" }
# variable "policy_document" { default = {} }
# variable "role_arns" { default = [] }
# variable "type" { default = "aws" }

variable "roles" {
  default = []
  type = list(object({
    credential_type = string
    name            = string
    role_arns       = list(string)
    policy_document = optional(map())
  }))
}
