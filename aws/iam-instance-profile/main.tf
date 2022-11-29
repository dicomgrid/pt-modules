resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
}
resource "aws_iam_instance_profile" "main" {
  name = var.name
  role = aws_iam_role.main.id
}

resource "aws_iam_role_policy" "main" {
  count  = var.policy == null ? 0 : 1
  name   = var.name
  role   = aws_iam_role.main.id
  policy = var.policy
}