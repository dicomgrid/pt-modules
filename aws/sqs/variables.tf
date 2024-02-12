locals {
  name = try(trimsuffix(var.name, ".fifo"), "")
}

variable "create" { default = true }
variable "create_queue_policy" { default = true }
variable "content_based_deduplication" { default = false }
variable "deduplication_scope" { default = null } #allowed values: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue#deduplication_scope
variable "delay_seconds" { default = 0 }
variable "encryption_type" {
  default = "sse"
  validation {
    condition     = contains(["sse", "kms"], var.encryption_type)
    error_message = "Expected encryption_type values:'sse','kms'"
  }
}
variable "fifo_queue" { default = false }
variable "fifo_throughput_limit" { default = null } #allowed values: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue#fifo_throughput_limit
variable "kms_data_key_reuse_period_seconds" { default = 300 }
variable "kms_master_key_id" { default = null }
variable "max_message_size" { default = 262144 }
variable "message_retention_seconds" { default = 345600 }
variable "name" { default = null }
variable "queue_policy_statements" { default = {} }
variable "receive_wait_time_seconds" { default = 0 }
variable "source_queue_policy_documents" { default = [] }
variable "override_queue_policy_documents" { default = [] }
variable "sqs_managed_sse_enabled" { default = true }
variable "tags" { default = null }
variable "use_name_prefix" { default = false }
variable "visibility_timeout_seconds" { default = 30 }
