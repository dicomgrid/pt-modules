
locals {
  additional_tags = {
    ObjectType = "subnet"
  }
}

resource "aws_flow_log" "enable_subnet_logs" {

  for_each             = toset(var.subnets)
  subnet_id            = each.value
  iam_role_arn         = var.iam_role_arn
  log_destination_type = var.log_destination_type
  log_destination      = var.log_destination
  traffic_type         = var.traffic_type

  max_aggregation_interval = var.max_aggregation_interval
  tags                     = merge(var.tags, local.additional_tags)
}
