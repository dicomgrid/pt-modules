## Vault Server IAM Config
resource "aws_iam_instance_profile" "main" {
  name = var.name
  role = var.role 
}

resource "aws_iam_role" "main" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy" "main" {
  name   = var.name
  role   = aws_iam_role.main.id
  policy = var.policy
}
