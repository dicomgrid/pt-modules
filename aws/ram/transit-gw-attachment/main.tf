# Create the VPC attachment in the second account...
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  provider = aws.second

  subnet_ids         = [for subnet_ids in local.az_subnets : subnet_ids[0]]
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id

}

# ...and accept it in the first account.
resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "main" {
  provider = aws.first

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.main.id
}

module "subnet_routes" {
  source = "../subnet-routes"
  providers = {
    aws = aws.second
  }

  for_each = toset(data.aws_route_tables.main.ids)

  destination_cidr_blocks = var.destination_cidr_blocks
  rtb_id                  = each.key
  vpc_id                  = var.vpc_id
  tgw_id                  = var.tgw_id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment_accepter.main]
}
