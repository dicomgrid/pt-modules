locals {
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.instance.arns)[0]
}

variable "aws_policies" {}
variable "name" {}
variable "description" {}
variable "duration" {}
variable "inline_policy" {}
variable "inline_policy_map" {}
variable "policies" {}