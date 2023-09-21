variable "allowed_managed_keys" { default = [] }
variable "cas_required" { default = true }
variable "delete_version_after" { default = 12600 }
variable "description" { default = "" }
variable "max_versions" { default = 5 }
variable "namespace" { default = null }
variable "kvv1_path" { default = "kv" }
variable "kvv2_path" { default = "secret" }