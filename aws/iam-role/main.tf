resource "aws_iam_role" "main" {
  name               = local.tags.Name
  assume_role_policy = var.assume_role_policy
  tags               = local.tags
}

resource "aws_iam_role_policy" "main" {
  count  = var.policy == null ? 0 : 1
  name   = local.tags.Name
  role   = aws_iam_role.main.id
  policy = var.policy
}

resource "aws_iam_instance_profile" "main" {
  count = var.instance_profile ? 1 : 0
  name  = local.tags.Name
  role  = aws_iam_role.main.id
  tags  = local.tags
}
