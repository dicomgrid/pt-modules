locals {
    account_id        = var.account_id == "" ? data.aws_caller_identity.current.account_id : var.account_id
}

variable "account_id" { default = "" }
variable "region" { default = "us-east-2" }