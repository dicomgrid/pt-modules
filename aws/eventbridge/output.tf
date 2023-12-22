output "eventbridge_rule_arn" {
  value = aws_cloudwatch_event_rule.eventbridge_rule.arn
}

output "eventbridge_target_arn" {
  value = aws_cloudwatch_event_target.eventbridge_target.arn
}