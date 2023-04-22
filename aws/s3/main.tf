resource "aws_s3_bucket" "main" {
  bucket = var.name
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

# TODO: Added features for encryption, replication, etc.
  tags = local.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  count = var.sse_enabled ? 1 : 0
  bucket = aws_s3_bucket.main.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.by_alias.arn
      sse_algorithm     = var.sse_algorithm
    }
  }
}
