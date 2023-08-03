data "aws_kms_key" "by_alias" {
  count  = var.kms_cmk_alias == null ? 0 : 1
  key_id = var.kms_cmk_alias
}
data "aws_canonical_user_id" "main" {}