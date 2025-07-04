locals {
  additional_tags = {
    ObjectType = "eni"
  }
}

resource "aws_flow_log" "enable-eni-logs" {

  for_each = { for eni in data.aws_network_interfaces.enis.ids : eni => eni }

  eni_id                   = each.key
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination
  max_aggregation_interval = var.max_aggregation_interval
  traffic_type             = var.traffic_type
  
  tags = merge(var.tags, local.additional_tags)
}