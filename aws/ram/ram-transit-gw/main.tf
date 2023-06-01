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
