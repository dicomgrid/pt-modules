resource "aws_s3_bucket" "s3" {
  bucket = var.name
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.sse_enabled ? [var.sse_algorithm] : []
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.bucket_key.arn
        sse_algorithm     = var.sse_algorithm
      }
    }
  }

# TODO: Added features for encryption, replication, etc.
  tags = local.tags
}