resource "aws_cloudwatch_event_rule" "eventbridge_rule" {
  name           = var.rule_name
  event_bus_name = var.eventbus_name
  event_pattern  = var.event_pattern
  schedule_expression = var.schedule_expression

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "eventbridge_target" {
  target_id = var.target_id
  rule      = aws_cloudwatch_event_rule.eventbridge_rule.name
  arn       = var.lambda_arn
}
