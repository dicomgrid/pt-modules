data "aws_iam_policy_document" "main" {
  dynamic "statement" {
    for_each = var.statements
    content {
      sid    = statement.value.sid
      effect = try(statement.value.effect, "Allow")
      dynamic "principals" {
        for_each = try(statement.value.principals, {})
        content {
          type        = try(principals.value.type, "AWS")
          identifiers = principals.value.identifiers
        }
      }
      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, {})
        content {
          type        = try(not_principals.value.type, "AWS")
          identifiers = not_principals.value.identifiers
        }
      }
      actions       = try(statement.value.actions, [])
      not_actions   = try(statement.value.not_actions, [])
      resources     = try(statement.value.resources, [])
      not_resources = try(statement.value.resources, [])
      dynamic "condition" {
        for_each = try(statement.value.condition, {})
        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}
