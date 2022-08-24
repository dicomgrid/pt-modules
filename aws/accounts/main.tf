resource "aws_organizations_account" "account" {
  for_each                   = var.accounts
  name                       = each.key
  email                      = each.value.email
  role_name                  = each.value.role
  iam_user_access_to_billing = var.access-billing
  parent_id                  = each.value.parent_id

  lifecycle {
    ignore_changes = [role_name, iam_user_access_to_billing]
  }
}

