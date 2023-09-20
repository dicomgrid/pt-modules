resource "aws_ebs_default_kms_key" "main" {
  key_arn = data.aws_kms_key.by_alias.arn
}

resource "aws_ebs_encryption_by_default" "main" {
  enabled = var.enabled
}
