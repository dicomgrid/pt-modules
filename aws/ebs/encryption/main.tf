resource "aws_ebs_encryption_by_default" "main" {
  enabled = var.enabled
}

resource "aws_ebs_default_kms_key" "ebs_default_kms_key" {
  key_arn = aws_kms_key.ebs_encryption_key.arn
}

resource "aws_kms_key" "ebs_encryption_key" {
  description = "Key used for ebs volume encryption"

  policy                  = data.aws_iam_policy_document.kms_ebs_policy.json
  deletion_window_in_days = var.kms_deletion_window_in_days
  tags                    = var.tags
}

resource "aws_kms_alias" "ebs_encryption_key_alias" {
  name          = var.kms_shared_ebs_alias
  target_key_id = aws_kms_key.ebs_encryption_key.key_id
}