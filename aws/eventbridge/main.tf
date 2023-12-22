resource "aws_cloudwatch_event_rule" "eventbridge_rule" {
  name           = var.rule_name
  event_bus_name = var.eventbus_name
  event_pattern  = <<EOF
{
  "source": ["aws.ssm"],
  "detail-type": ["Maintenance Window Task Execution State-change Notification"],
  "detail": {
    "status": ["FAILED"]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "eventbridge_target" {
  target_id = "lambda"
  rule      = aws_cloudwatch_event_rule.eventbridge_rule.name
  arn       = var.lambda_arn
}
