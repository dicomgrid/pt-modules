resource "aws_organizations_account" "account" {
  name              = var.name
  close_on_deletion = var.close_on_deletion
  email             = coalesce(var.email, local.email)
  parent_id         = local.ou_map[var.ou_name]
  role_name         = var.role
  tags              = local.tags

  lifecycle {
    ignore_changes = [
      email,
      iam_user_access_to_billing,
      parent_id,
      role_name,
    ]
  }
}

