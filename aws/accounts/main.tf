resource "aws_organizations_account" "account" {
  name                       = var.name
  email                      = var.email
  role_name                  = var.role
  iam_user_access_to_billing = var.access_billing
  parent_id                  = var.parent_id_map[var.parent_id]

  dynamic "tags" {
    for_each                   = var.tags
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

