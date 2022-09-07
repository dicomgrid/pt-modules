data "aws_instances" "main" {
  filter {
    name   = "tag:Name"
    values = var.target_instances
  }
}

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

data "aws_security_groups" "main" {
  count = var.load_balancer_type == "application" ? 1 : 0
  filter {
    name   = "tag:Name"
    values = var.security_groups
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}