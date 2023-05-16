data "aws_iam_policy" "aws" {
  for_each = toset(var.aws_policies)
  name     = each.value
}