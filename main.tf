# Get VPC Info
data "aws_vpc" "main" {

  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Getting list of all subnet ids based on vpc
data "aws_subnets" "main" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Name = var.subnets_filter
  }
}

# Piping returned subnets for az info
data "aws_subnet" "main" {
  for_each = toset(data.aws_subnets.main.ids)

  id = each.value
}