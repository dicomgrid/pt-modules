data "aws_kms_key" "by_alias" {
  key_id = var.key_alias
}