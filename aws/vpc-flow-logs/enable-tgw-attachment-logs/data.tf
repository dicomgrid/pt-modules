data "aws_ec2_transit_gateway_attachments" "filtered" {
  filter {
    name   = "resource-id"
    values = [var.vpc_id]
  }
}
