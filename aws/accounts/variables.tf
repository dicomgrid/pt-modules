variable "access-billing" {
  default     = "ALLOW"
  type        = string
  description = "If set to ALLOW, the new account enables IAM users to access account billing information."
}

variable "accounts" {
    type = map 
    default = {}
}

variable "enabled" {
  default     = true
  type        = string
  description = "Set to false to prevent the module from creating anything."
}

variable "parent-id" {
  type = string
  default = "r-53vz"
}

variable "ou-scp" {
  type = list
}

