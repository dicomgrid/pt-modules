resource "aws_iam_group" "main" {
  name     = var.name
  path     = var.path
}

resource "aws_iam_group_policy" "main" {
  name  = "${var.name}-policy"
  group = aws_iam_group.main.name
  policy = var.policy
}