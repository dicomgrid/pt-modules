# Get list of all subnet ids based on vpc and tags
data "aws_subnets" "rtb" {

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = var.subnets_tags_filter

}

# Get route table ids for route tables associated with provided subnet ids
data "aws_route_tables" "main" {
  vpc_id = var.vpc_id

  filter {
    name   = "association.subnet-id"
    values = data.aws_subnets.rtb.ids
  }
}
