# Get list of all subnet ids based on vpc and tags
data "aws_subnets" "main" {

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = var.subnets_tags_filter
}

# Piping returned subnets for az info
data "aws_subnet" "main" {
  for_each = toset(data.aws_subnets.main.ids)

  id = each.value
}
