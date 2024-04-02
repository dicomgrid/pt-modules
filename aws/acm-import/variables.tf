variable "cert_key" {
  default     = ""
  description = "Key name for the cert in vault path"
}

variable "cert_chain_key" {
  default     = ""
  description = "Key name for the cert chain in vault path"
}

variable "private-key_key" {
  default     = ""
  description = "Key name for the cert key in vault path"
}

variable "namespace" {
  default     = ""
  description = "Vault Namespace"
}

variable "mount" {
  default     = "secret"
  description = "Vault mount"
}

variable "vault_secret_name" {
  default     = ""
  description = "Vault Namespace"
}
# Tags
locals {
  default_tags = {
    CodeManaged = var.code_managed
  }
  tags = merge(local.default_tags, var.tags)
}
variable "tags" { default = {} }


variable "code_managed" { default = "true" }

