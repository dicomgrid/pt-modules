resource "aws_organizations_policy" "main" {
  name        = var.name
  content     = var.content
  description = var.description
  type        = var.type
}

resource "aws_organizations_policy_attachment" "main" {
  policy_id = aws_organizations_policy.main.id
  target_id = local.ou_map[var.ou_name]
}

