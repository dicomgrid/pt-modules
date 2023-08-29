locals {
  additional_tags = {
    ObjectType = "vpc"
  }
}

resource "aws_flow_log" "enable-vpc-logs" {
  for_each = { for vpc_id in data.aws_vpcs.selected_vpcs.ids : vpc_id => vpc_id }

  iam_role_arn         = var.iam_role_arn
  log_destination_type = var.log_destination_type
  log_destination      = var.log_destination
  traffic_type         = var.traffic_type
  vpc_id               = each.key # Using the VPC ID from the loop

  max_aggregation_interval = var.max_aggregation_interval
  tags                     = merge(var.tags, local.additional_tags)

}
