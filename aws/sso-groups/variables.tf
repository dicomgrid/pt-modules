locals {
  sso_instance_arn    = tolist(data.aws_ssoadmin_instances.permission_set.arns)[0]
}

variable "name" {}
variable "description" {}
variable "duration" {}
variable "inline_policy" {}
variable "group" {}
variable "account_list" {
  default = ([])
}