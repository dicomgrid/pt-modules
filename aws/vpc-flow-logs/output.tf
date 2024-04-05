output "log_group_name" {
description = "The name of the CloudWatch log group."
value       = aws_cloudwatch_log_group.log_group[0].name
}

output "log_group_arn" {
description = "The ARN of the CloudWatch log group."
value       = aws_cloudwatch_log_group.log_group[0].arn
}

output "log_stream_name" {
description = "The name of the CloudWatch log stream."
value       = aws_cloudwatch_log_stream.log_name[0].name
}
