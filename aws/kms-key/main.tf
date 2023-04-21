resource "aws_kms_key" "main" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  tags = local.tags
}

resource "aws_kms_alias" "main" {
  name          = var.kms_alias == null ? "alias/${var.name}" : var.kms_alias
  target_key_id = aws_kms_key.main.key_id
}

resource "aws_kms_key_policy" "main" {
  count = var.kms_policy_enabled ? 1 : 0
  key_id = aws_kms_key.main.id
  policy = local.kms_policy
}