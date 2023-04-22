# TODO: Added features for replication and lifecycle rules etc.
resource "aws_s3_bucket" "main" {
  bucket = var.name
  tags = local.tags
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = var.acl
}

# Versioning
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = var.versioning_status
  }
}
/* Need to determine default lifecycle rules
resource "aws_s3_bucket_lifecycle_configuration" "main" {
  # Must have bucket versioning enabled first
  bucket = aws_s3_bucket_versioning.main.id

  rule {
    id = "config"

    filter {
      prefix = "config/"
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    status = "Enabled"
  }
}
*/

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  count = var.sse_enabled ? 1 : 0
  bucket = aws_s3_bucket.main.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.aws_kms_key.by_alias[0].arn
      sse_algorithm     = var.sse_algorithm
    }
  }
}

# Logging
resource "aws_s3_bucket" "log_bucket" {
  count = var.logging_enabled ? 1 : 0
  bucket = "${var.name}-log-bucket"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  count = var.logging_enabled ? 1 : 0
  bucket = aws_s3_bucket.log_bucket[0].id
  acl    = var.logging_acl
}

resource "aws_s3_bucket_lifecycle_configuration" "log_bucket" {
  count = var.logging_enabled ? 1 : 0
  bucket = aws_s3_bucket.log_bucket[0].id

  rule {
    id = "log"

    expiration {
      days = var.logging_expiration
    }

    filter {
      and {
        prefix = "log/"
      }
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "main" {
  count = var.logging_enabled ? 1 : 0
  bucket = aws_s3_bucket.main.id

  target_bucket = aws_s3_bucket.log_bucket[0].id
  target_prefix = "log/"
}