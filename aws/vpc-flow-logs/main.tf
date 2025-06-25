
locals {
  log_destination   = var.log_destination
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  name              = local.log_destination
  retention_in_days = local.retention_in_days
  tags              = local.tags
}
resource "aws_cloudwatch_log_stream" "log_name" {
  count          = var.log_destination_type == "cloud-watch-logs" ? 1 : 0
  name           = aws_cloudwatch_log_group.log_group[0].name
  log_group_name = aws_cloudwatch_log_group.log_group[0].name
}

module "enable-eni-logs" {
  source                   = "./enable-eni-logs"
  count                    = var.enable-eni-logs ? 1 : 0
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.log_group[0].arn : var.log_destination
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}
module "enable-vpc-logs" {
  source                   = "./enable-vpc-logs"
  count                    = var.enable-vpc-logs ? 1 : 0
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.log_group[0].arn : var.log_destination
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  enable-vpc-logs          = var.enable-vpc-logs
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}

module "enable-subnet-logs" {
  count                    = var.enable-subnet-logs ? 1 : 0
  source                   = "./enable-subnet-logs"
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.log_group[0].arn : var.log_destination
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  subnets                  = data.aws_subnets.get_subnets.ids
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}

module "enable-tgw-attachment-logs" {
  count                    = var.enable-tgw-attachment-logs ? 1 : 0
  source                   = "./enable-tgw-attachment-logs"
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination_type == "cloud-watch-logs" ? aws_cloudwatch_log_group.log_group[0].arn : var.log_destination
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}

