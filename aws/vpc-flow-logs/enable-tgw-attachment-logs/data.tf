data "aws_ec2_transit_gateway_attachments" "filtered" {
  filter {
    name   = "resource-id"
    values = [var.vpc_id]
  }
}

data "aws_ec2_transit_gateway_attachments" "filtered" {
  # Example filter, update as needed
  filter {
    name   = "transit-gateway-id"
    values = [var.transit_gateway_id]
  }
}
