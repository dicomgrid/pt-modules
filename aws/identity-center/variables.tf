locals {
  #aws_policies = data.aws_iam_policy.aws
  #policies = data.aws_iam_policy.customer
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.instance.arns)[0]
}

variable "account_list" {
  default = ([])
}
variable "aws_policies" {}
variable "name" {}
variable "description" {}
variable "duration" {}
variable "inline_policy" {}
variable "inline_policy_map" {}
variable "group" {}
variable "policies" {}