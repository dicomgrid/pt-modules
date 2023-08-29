data "aws_region" "current" {}


data "aws_ec2_transit_gateway_attachments" "attachments" {
  filter {

    name   = "resource-id"
    values = [var.vpc_id]
  }
}
data "aws_subnets" "get_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "get_subnets" {
  for_each = { for s in data.aws_subnets.get_subnets.ids : s => s }
  id       = each.value
}
