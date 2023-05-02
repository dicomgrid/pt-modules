variable "groups" {}
variable "name" {}
variable "path" { default = null }
variable "service_account" {}
variable "service_account_map" {
  type = map(any)
  default = {
    true  = false
    false = true
  }
}


# Tags
locals {
  default_tags = {
    CodeManaged = var.code_managed
    Compliance  = var.compliance
    Email       = var.email
    Environment = var.environment
    Name        = "iam_user:${var.name}"
    Owner       = var.owner
    Product     = var.product
    User_Name   = "${var.first_name} ${var.last_name}"
    User_Type   = var.user_type
  }
  tags = merge(local.default_tags, var.tags)
}
variable "tags" {}

variable "billing" { default = "platform" }
variable "compliance" { default = "null" }
variable "email" {}
variable "environment" { default = "master" }
variable "first_name" {}
variable "last_name" {}
variable "owner" { default = "platform" }
variable "product" { default = "iam" }
variable "user_type" {}