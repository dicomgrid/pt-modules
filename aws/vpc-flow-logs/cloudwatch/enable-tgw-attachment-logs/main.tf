locals {
  transit_gateways_in_vpc = {
    for attachment in data.aws_ec2_transit_gateway_attachments.filtered.ids :
    attachment => attachment
  }
  additional_tags = {
    ObjectType = "tgw"
  }
}
resource "aws_flow_log" "enable-tgw-attachment-logs" {
  for_each                      = local.transit_gateways_in_vpc

  iam_role_arn                  = var.iam_role_arn
  transit_gateway_attachment_id = each.key
  log_destination_type          = var.log_destination_type
  log_destination               = var.log_destination
  max_aggregation_interval      = var.max_aggregation_interval
  traffic_type                  = var.traffic_type
  tags                          = merge(var.tags, local.additional_tags)

}
