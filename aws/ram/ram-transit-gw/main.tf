resource "aws_ram_resource_share" "main" {
  name = var.resource_share_name

  tags = {
    Name = var.resource_share_name
  }
}

# Share the transit gateway...
resource "aws_ram_resource_association" "main" {
  resource_arn       = data.aws_ec2_transit_gateway.main.arn
  resource_share_arn = aws_ram_resource_share.main.arn
}

# ...with the second account.
resource "aws_ram_principal_association" "main" {
  for_each = toset(var.account_ids)

  principal          = each.value
  resource_share_arn = aws_ram_resource_share.main.arn
}


# # Create the VPC attachment in the second account...
# resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
#   provider = aws.second

#   depends_on = [
#     aws_ram_principal_association.main,
#     aws_ram_resource_association.main,
#   ]

#   subnet_ids         = [data.aws_subnets.main.id]
#   transit_gateway_id = var.tgw_id
#   vpc_id             = var.vpc_id

# }

# # ...and accept it in the first account.
# resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "main" {
#   provider = aws.first

#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.main.id

# }