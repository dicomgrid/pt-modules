variable "name" {}

variable "acl" {
  default = "private"
}

variable "billing" {
  default = ""
}

variable "application" {
  default = ""
}

variable "creator" {
  default = ""
}

variable "owner" {
  default = ""
}

variable "environment" {
  default = ""
}
variable "kms_key_alias" { default = null }
variable "server_side_encryption_enabled" { default = false }
variable "sse_algorithm" { default = "aws:kms" }

variable "versioning" {
  default = true
}
