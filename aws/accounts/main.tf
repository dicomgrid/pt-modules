resource "aws_organizations_account" "account" {
  for_each                   = var.accounts
  name                       = each.key
  email                      = each.value.email
  role_name                  = each.value.role
  iam_user_access_to_billing = var.access-billing
  parent_id                  = aws_organizations_organizational_unit.org[each.value.environment].id

  lifecycle {
    ignore_changes = [role_name, iam_user_access_to_billing]
  }
}

