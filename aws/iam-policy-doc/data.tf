data "aws_iam_policy_document" "main" {
  dynamic "statement" {
    for_each = var.statements
    content {
      sid    = statement.value.sid
      effect = lookup(statement.value, "effect", "Allow")
      dynamic "principals" {
        for_each = statement.value.principals
        content {
          type        = lookup(principals.value, "type", "AWS")
          identifiers = principals.value.identifiers
        }
      }
      actions       = lookup(statement.value, "actions", [])
      not_actions   = lookup(statement.value, "not_actions", [])
      resources     = lookup(statement.value, "resources", [])
      not_resources = lookup(statement.value, "resources", [])
    }
  }
}
