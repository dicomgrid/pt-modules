resource "aws_ram_resource_share" "main" {
  provider = aws.first

  name = var.resource_share_name

  tags = {
    Name = var.resource_share_name
  }
}

# Share the transit gateway...
resource "aws_ram_resource_association" "main" {
  provider = aws.first

  resource_arn       = data.aws_ec2_transit_gateway.main.arn
  resource_share_arn = aws_ram_resource_share.main.arn
}

# ...with the second account.
resource "aws_ram_principal_association" "main" {
  provider = aws.first
  for_each = var.account_ids
  
  principal          = each.value
  resource_share_arn = aws_ram_resource_share.main.arn
}


# Create the VPC attachment in the second account...
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  provider = aws.second

  depends_on = [
    aws_ram_principal_association.main,
    aws_ram_resource_association.main,
  ]

  subnet_ids         = [data.aws_subnets.main.id]
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.main.id

}

# ...and accept it in the first account.
resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "main" {
  provider = aws.first

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.main.id

}