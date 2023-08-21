
data "aws_iam_role" "existing_role" {
  name = var.iam_role_name
}
data "aws_ec2_transit_gateway_attachments" "attachments" {
  filter {

    name   = "resource-id"
    values = [var.vpc_id]
  }
}
data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "example" {
  for_each = { for s in data.aws_subnets.example.ids : s => s }
  id       = each.value
}
