locals {
  sso_instance_arn    = tolist(data.aws_ssoadmin_instances.permission_set.arns)[0]
}

data "aws_ssoadmin_instances" "permission_set" {}

resource "aws_ssoadmin_permission_set" "permission_set" {
  name             = var.name
  description      = var.description
  instance_arn     = local.sso_instance_arn
  session_duration = var.duration
}

resource "aws_ssoadmin_permission_set_inline_policy" "permission_set" {
  inline_policy      = var.inline_policy
  instance_arn       = aws_ssoadmin_permission_set.permission_set.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.permission_set.arn
}


