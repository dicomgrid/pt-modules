resource "aws_ram_principal_association" "main" {
  for_each = toset(var.principals)

  principal          = each.key
  resource_share_arn = var.resource_share_arn
}
