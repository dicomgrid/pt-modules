

resource "aws_cloudwatch_log_group" "log_group" {

  name              = var.log_destination
  retention_in_days = var.retention_in_days
  tags              = var.tags
}
resource "aws_cloudwatch_log_stream" "log_name" {
  name           = aws_cloudwatch_log_group.log_group.name
  log_group_name = aws_cloudwatch_log_group.log_group.name
}


module "enable_eni_logs" {
  source                   = "git::ssh://git@github.com/dicomgrid/pt-modules.git//aws/flow-logs/cloudwatch_flow_logs/enable_eni_logs?ref=PLT-1339x2"
  count                    = var.enable_eni_logs ? 1 : 0
  iam_role_arn             = data.aws_iam_role.existing_role
  log_destination_type     = var.log_destination_type
  log_destination          = aws_cloudwatch_log_group.log_name.arn
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  max_aggregation_interval = var.max_aggregation_interval

  tags = var.tags
}
module "enable_vpc_logs" {
  source                   = "git::ssh://git@github.com/dicomgrid/pt-modules.git//aws/flow-logs/cloudwatch_flow_logs/enable_vpc_logs?ref=PLT-1339x2"
  count                    = var.enable_vpc_logs ? 1 : 0
  iam_role_arn             = data.aws_iam_role.existing_role
  log_destination_type     = var.log_destination_type
  log_destination          = aws_cloudwatch_log_group.log_name
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  enable_vpc_logs          = var.enable_vpc_logs
  max_aggregation_interval = var.max_aggregation_interval


  tags = var.tags
}
# Attach IAM policy to the IAM role

module "enable_subnet_logs" {
  source = "git::ssh://git@github.com/dicomgrid/pt-modules.git//aws/flow-logs/cloudwatch_flow_logs/enable_subnet_logs?ref=PLT-1339x2"
  count  = var.enable_subnet_logs ? 1 : 0

  iam_role_arn             = data.aws_iam_role.existing_role
  log_destination_type     = var.log_destination_type
  log_destination          = aws_cloudwatch_log_group.log_group.arn
  traffic_type             = var.traffic_type
  vpc_id                   = var.vpc_id
  subnets                  = data.aws_subnets.example.ids
  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}

module "enable_tgw_attachment_logs" {
  source = "git::ssh://git@github.com/dicomgrid/pt-modules.git//aws/flow-logs/cloudwatch_flow_logs/enable_tgw_attachment_logs?ref=PLT-1339x2"
  count  = var.enable_tgw_attachment_logs ? 1 : 0


  iam_role_arn         = data.aws_iam_role.existing_role
  log_destination_type = var.log_destination_type
  log_destination      = aws_cloudwatch_log_group.log_group.arn
  traffic_type         = var.traffic_type
  vpc_id               = var.vpc_id

  max_aggregation_interval = var.max_aggregation_interval
  tags                     = var.tags
}
