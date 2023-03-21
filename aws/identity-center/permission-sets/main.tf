resource "aws_ssoadmin_permission_set" "permission_set" {
  name             = var.name
  description      = var.description
  instance_arn     = var.sso_instance_arn
  session_duration = var.duration
}

resource "aws_ssoadmin_permission_set_inline_policy" "permission_set" {
  count              = var.inline_policy == null ? 0 : 1
  inline_policy      = var.inline_policy_map[var.inline_policy]
  instance_arn       = var.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.permission_set.arn
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "main" {
  for_each           = data.aws_iam_policy.customer
  instance_arn       = var.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.permission_set.arn
  customer_managed_policy_reference {
    name = each.value.name
    path = each.value.path
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "main" {
  for_each           = data.aws_iam_policy.aws
  instance_arn       = var.sso_instance_arn
  managed_policy_arn = each.value.arn
  permission_set_arn = aws_ssoadmin_permission_set.permission_set.arn
}
