resource "aws_organizations_account" "account" {
  for_each                   = var.accounts
  name                       = each.key
  email                      = each.value.email
  role_name                  = each.value.role
  iam_user_access_to_billing = var.access_billing
  parent_id                  = var.parent_id[each.value.parent_id]

  dynamic "tags" {
    for_each                   = each.value.tags
    content {
      name                  = lookup(each.value, "name" , null)
      department            = lookup(each.value, "department" , null)
      ambra-storage         = lookup(each.value, "ambra-storage" , null)
    }
  }

  lifecycle {
    ignore_changes = [role_name, iam_user_access_to_billing]
  }
}

