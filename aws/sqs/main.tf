resource "aws_sqs_queue" "main" {
  count = var.create ? 1 : 0

  content_based_deduplication       = var.content_based_deduplication
  deduplication_scope               = var.fifo_queue ? var.deduplication_scope : null
  delay_seconds                     = var.delay_seconds
  fifo_queue                        = var.fifo_queue
  fifo_throughput_limit             = var.fifo_queue ? var.fifo_throughput_limit : null
  kms_data_key_reuse_period_seconds = var.encryption_type == "kms" ? var.kms_data_key_reuse_period_seconds : null
  kms_master_key_id                 = var.encryption_type == "kms" ? var.kms_master_key_id : null
  max_message_size                  = var.max_message_size
  message_retention_seconds         = var.message_retention_seconds
  name                              = var.use_name_prefix ? null : (var.fifo_queue ? "${local.name}.fifo" : local.name)
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  sqs_managed_sse_enabled           = var.encryption_type == "sse" ? true : null
  visibility_timeout_seconds        = var.visibility_timeout_seconds

  tags = var.tags
}

#TODO: Adapt to use kms module
# resource "aws_kms_key" "main" {
#   count = var.encryption_type == "kms" ? 1 : 0
#   description = var.use_name_prefix ? null : (var.fifo_queue ? "${local.name}.fifo.sqs-key" : "${local.name}-sqs-key")
# }

data "aws_iam_policy_document" "main" {
  count = var.create && var.create_queue_policy ? 1 : 0

  source_policy_documents   = var.source_queue_policy_documents
  override_policy_documents = var.override_queue_policy_documents

  dynamic "statement" {
    for_each = var.queue_policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = try(statement.value.resources, [aws_sqs_queue.main[0].arn])
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_sqs_queue_policy" "main" {
  count = var.create && var.create_queue_policy ? 1 : 0

  queue_url = aws_sqs_queue.main[0].url
  policy    = data.aws_iam_policy_document.main[0].json
}
