variable "application" {
  default = ""
}

variable "billing" {
  default = ""
}

variable "creator" {
  default = "Terraform"
}

variable "encryption_type" {
  default = "AES256"
}

variable "environment" {
  default = "production"
}

variable "image_tag_mutability" {
  default = "MUTABLE"
}

variable "name" {}

variable "owner" {
  default = "DevOps"
}

variable "scan_on_push" {
  default = true
}

variable "cross_account_access" {
  default = false
}