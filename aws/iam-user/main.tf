resource "aws_iam_user" "main" {
  name          = var.name
  path          = var.path
  force_destroy = var.service_account_map[var.service_account]
  tags          = local.tags
}

resource "aws_iam_user_policy" "main" {
  count  = var.inline_policy != null ? 1 : 0
  name   = "${var.name}-user-policy"
  user   = aws_iam_user.main.name
  policy = var.inline_policy
}

resource "aws_iam_user_policy_attachment" "main" {
  for_each = data.aws_iam_policy.aws
  user   = aws_iam_user.main.name
  policy_arn = each.value.arn
}

resource "aws_iam_user_group_membership" "main" {
  count = var.groups != [] ? 1 : 0
  user   = aws_iam_user.main.name
  groups = var.groups
}