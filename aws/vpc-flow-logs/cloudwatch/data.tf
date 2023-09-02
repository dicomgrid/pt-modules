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