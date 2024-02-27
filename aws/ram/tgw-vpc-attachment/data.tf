# getting list of all subnet ids based on vpc for TGWA
data "aws_subnets" "main" {
  provider = aws.requester

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  dynamic "filter" {
    for_each = length(var.tgwa_subnet_name_values) > 0 ? [var.tgwa_subnet_name_values] : []

    content {
      name   = "tag:Name"
      values = filter.value
    }
  }
}

#piping returned subnets for az info for TGWA
data "aws_subnet" "main" {
  provider = aws.requester
  for_each = toset(data.aws_subnets.main.ids)

  id = each.value
}

# Get list of all subnet ids based on vpc and tag:Name for subnet_routes
data "aws_subnets" "routes" {
  provider = aws.requester

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  dynamic "filter" {
    for_each = length(var.routes_subnet_name_values) > 0 ? [var.routes_subnet_name_values] : []

    content {
      name   = "tag:Name"
      values = filter.value
    }
  }

}

# Get route table ids for route tables associated with provided subnet ids for subnet_routes
data "aws_route_tables" "routes" {
  provider = aws.requester
  vpc_id   = var.vpc_id

  filter {
    name   = "association.subnet-id"
    values = data.aws_subnets.routes.ids
  }
}
