provider "aws" {
  region = var.region
}

module "cw_log_group" {
source = ./cw-log-group
for_each = toset(local.vpcs)
}

module "enable-eni-logs" { 
  source                   = ./enable-log-logs
 
  count                    = var.enable-vpc-logs ? 1 : 0
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = aws_cloudwatch_log_group.log_group.arn
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}

module "enable-subnet-logs" {
  count                    = var.enable-subnet-logs ? 1 : 0
  source                   = ./enable-subnet-tags
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = aws_cloudwatch_log_group.log_group.arn
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  subnets                  = data.aws_subnets.get_subnets.ids
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}

module "enable-tgw-attachment-logs" {
  count                    = var.enable-tgw-attachment-logs ? 1 : 0
  iam_role_arn             = var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = aws_cloudwatch_log_group.log_group.arn
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}     