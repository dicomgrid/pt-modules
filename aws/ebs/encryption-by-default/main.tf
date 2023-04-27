resource "aws_ebs_default_kms_key" "main" {
  key_arn = local.key_arn
}

resource "aws_ebs_encryption_by_default" "main" {
  enabled = var.enabled
}