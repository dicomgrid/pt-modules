resource "aws_cloudwatch_log_group" "log_group_per_vpc" {
for_each = toset(local.vpc_id)

name              = "vpc-flow-logs-${each.value}"
retention_in_days = var.retention_in_days

tags = merge(
    var.tags,
{
   "VPC_ID" = each.value
}
)
}

resource "aws_cloudwatch_log_stream" "log_stream_per_vpc" {
for_each = toset(local.vpc_id)

name           = "vpc-flow-logs-stream-${each.value}"
log_group_name = aws_cloudwatch_log_group.log_group_per_vpc[each.value].name
}