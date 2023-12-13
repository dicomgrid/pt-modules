# TODO: Added features for replication and lifecycle rules etc.
resource "aws_s3_bucket" "main" {
  bucket = local.tags.Name
  object_lock_enabled = var.object_lock_enabled
  tags   = local.tags
}

resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket_ownership_controls.main.id
  expected_bucket_owner = try (var.expected_bucket_owner, "BucketOwnerPreferred")
  acl    = local.acl

  dynamic access_control_policy {
    for_each = var.access_control_policy == null ? [] : [var.access_control_policy]
    content {
      dynamic "grant" {
        for_each = access_control_policy.value.grants
        content {
            grantee {
              email_address = try(grant.value.email_address, null)
              id   = try(grant.value.id, null)
              type = grant.value.type
              uri = try(grant.value.uri, null)
            }
            permission = grant.value.permission
        }
      }
      owner {
        id = try(access_control_policy.value.owner_id, data.aws_canonical_user_id.main.id)
        display_name = try(access_control_policy.value.owner_display_name, null)
      }
    }
  }
}

# Objects (Directories)
resource "aws_s3_object" "main" {
  for_each = var.directories
  bucket   = aws_s3_bucket.main.id
  key      = each.key
}

# Versioning
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  count = length(var.lifecycle_rules) > 0 ? 1 : 0

  bucket = aws_s3_bucket.main.id

  dynamic "rule" {

    for_each = var.lifecycle_rules

    content {
      id     = rule.value.id
      status = rule.value.status

      filter {
        object_size_greater_than = lookup(rule.value.filter, "object_size_greater_than", null)
        object_size_less_than    = lookup(rule.value.filter, "object_size_less_than", null)
        prefix                   = lookup(rule.value.filter, "prefix", "")
      }

      dynamic "expiration" {
        for_each = lookup(rule.value, "expiration", [])
        content {
          days = lookup(expiration.value, "days", null)
          date = lookup(expiration.value, "date", null)
        }
      }

      dynamic "transition" {
        for_each = lookup(rule.value, "transitions", [])
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lookup(rule.value, "noncurrent_version_expiration", [])
        content {
          newer_noncurrent_versions = noncurrent_version_expiration.value.newer_noncurrent_versions
          noncurrent_days           = noncurrent_version_expiration.value.noncurrent_days
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lookup(rule.value, "noncurrent_version_transitions", [])
        content {
          newer_noncurrent_versions = noncurrent_version_transition.value.newer_noncurrent_versions
          noncurrent_days           = noncurrent_version_transition.value.noncurrent_days
          storage_class             = noncurrent_version_transition.value.storage_class
        }
      }

    }
  }
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  count  = var.sse_enabled ? 1 : 0
  bucket = aws_s3_bucket.main.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = try(data.aws_kms_key.by_alias[0].arn, null)
      sse_algorithm     = var.sse_algorithm
    }

    bucket_key_enabled = var.bucket_key_enabled
  }
}

# Logging
resource "aws_s3_bucket" "log_bucket" {
  count  = var.logging_enabled ? 1 : 0
  bucket = "${local.tags.Name}-log-bucket"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  count  = var.logging_enabled ? 1 : 0
  bucket = aws_s3_bucket.log_bucket[0].id
  acl    = var.logging_acl
}

resource "aws_s3_bucket_lifecycle_configuration" "log_bucket" {
  count  = var.logging_enabled ? 1 : 0
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

resource "aws_s3_bucket_policy" "main" {
  count  = var.bucket_policy_enabled ? 1 : 0
  bucket = aws_s3_bucket.main.id
  policy = var.bucket_policy
}

resource "aws_s3_bucket_logging" "main" {
  count  = var.logging_enabled ? 1 : 0
  bucket = aws_s3_bucket.main.id

  target_bucket = aws_s3_bucket.log_bucket[0].id
  target_prefix = "log/"
}

#Object Lock
resource "aws_s3_bucket_object_lock_configuration" "main" {
  count = var.object_lock_enabled ? 1 : 0
  bucket = aws_s3_bucket.main.id
  dynamic "rule" {
    for_each = var.object_lock_period
    content {
      default_retention {
        mode = local.object_lock_period[0].mode
        days = local.object_lock_period[0].days
      }
    }
  }
}