data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc]
  }
}

data "aws_subnets" "main" {
  filter {
    name   = "tag:Name"
    values = var.subnets
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

####