# Get VPC Info
# data "aws_vpc" "main" {

#   filter {
#     name   = "tag:Name"
#     values = [var.vpc]
#   }
# }

# Getting list of all subnet ids based on vpc
# data "aws_subnets" "main" {

#   filter {
#     name   = "vpc-id"
#     values = [var.vpc_id]
#   }
# }

data "aws_subnets" "main" {

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name   = var.subnets_tag_name
  }
}

# Piping returned subnets for az info
data "aws_subnet" "main" {
  for_each = toset(data.aws_subnets.main.ids)

  id = each.value
}

locals {
  az_subnets = {
    for s in data.aws_subnet.main : s.availability_zone => s.id...
  }
}

# Create the VPC attachment request
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {

  subnet_ids         = [for subnet_ids in local.az_subnets : subnet_ids[0]]
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id
  tags = local.tags
}