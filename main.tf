resource "aws_cloudwatch_log_group" "main" {
  name              = local.tags.Name
  skip_destroy      = var.skip_destroy
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id
  lifecycle {
    create_before_destroy = true
  }
  tags = local.tags
}