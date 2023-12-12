resource "aws_iam_policy" "main" {
  description = var.description
  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  policy      = var.policy
  tags        = var.tags
}
