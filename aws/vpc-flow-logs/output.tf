output "log_group_name" {
description = "The name of the CloudWatch log group."
value       = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.log_group[0].name : null
}

output "log_group_arn" {
description = "The ARN of the CloudWatch log group."
value       = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.log_group[0].arn : null
}

output "log_stream_name" {
description = "The name of the CloudWatch log stream."
value       = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.log_stream[0].name : null
}
