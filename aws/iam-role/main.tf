resource "aws_iam_role" "main" {
  name               = local.tags.Name
  assume_role_policy = var.assume_role_policy
  tags               = local.tags
}

# Inline Only
resource "aws_iam_role_policy" "main" {
  for_each = var.policies
  name     = each.key
  role     = aws_iam_role.main.id
  policy   = each.value
}

# AWs/Custmoer Managed
resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = toset(var.managed_policies)
  role       = aws_iam_role.main.name
  policy_arn = each.key
}

resource "aws_iam_instance_profile" "main" {
  count = var.instance_profile ? 1 : 0
  name  = local.tags.Name
  role  = aws_iam_role.main.id
  tags  = local.tags
}
