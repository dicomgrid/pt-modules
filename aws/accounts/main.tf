resource "aws_organizations_account" "account" {
  name      = var.name
  email     = "devops+${var.name}@intelerad.com"
  role_name = var.role
  parent_id = local.ou_map[var.ou_name]
  #tags                       = var.tags

  lifecycle {
    ignore_changes = [role_name, iam_user_access_to_billing]
  }
}

