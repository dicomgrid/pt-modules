output "queue_arn" {
  description = "The ARN of the SQS queue"
  value       = try(aws_sqs_queue.main[0].arn, null)
}