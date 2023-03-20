data "aws_ssoadmin_instances" "instance" {}

data "aws_iam_policy" "customer" {
  for_each = toset(var.policies)
  name     = each.value
}

data "aws_iam_policy" "aws" {
  for_each = toset(var.aws_policies)
  name     = each.value
}