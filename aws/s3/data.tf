data "aws_kms_key" "by_alias" {
  count  = var.sse_enabled ? 1 : 0
  key_id = var.kms_key_alias
}