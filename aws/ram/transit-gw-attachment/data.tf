# getting list of all subnet ids based on vpc
data "aws_subnets" "main" {
  provider = aws.second

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

#piping returned subnets for az info
data "aws_subnet" "main" {
  provider = aws.second
  for_each = toset(data.aws_subnets.main.ids)

  id = each.value
}
