variable "access-billing" {
  default     = "ALLOW"
  type        = string
  description = "If set to ALLOW, the new account enables IAM users to access account billing information."
}

variable "accounts" {
  type    = map(any)
  default = {}
}

variable "enabled" {
  default     = true
  type        = string
  description = "Set to false to prevent the module from creating anything."
}

variable "parent-id" {
  default = {
    ambra_health       = "ou-53vz-yludznnj"
    ambra_dev          = "ou-53vz-gwvk7qhd"
    ambra_prod         = "ou-53vz-8erqn478"
    ambra_uat          = "ou-53vz-n7ekg6ry"
    ambra_dev_storage  = "ou-53vz-l5l0aoz8"
    ambra_uat_storage  = "ou-53vz-aypewb4f"
    ambra_prod_storage = "ou-53vz-hedgvb2o"

  }
}


variable "tags" {
  type    = map(any)
  default = {}
}

