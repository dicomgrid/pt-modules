locals {
  auth_methods = merge(
    {
      oidc = {}
      jwt  = {}
    },
    var.auth_methods
  )
}

variable "auth_methods" { default = {} }
variable "groups" { default = {} }
variable "namespace" { default = null }
variable "policies" { default = {} }
