# Create the VPC attachment in the second account...
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  provider = aws.second

  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id

}

# ...and accept it in the first account.
resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "main" {
  provider = aws.first

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.main.id

}