resource "aws_ram_principal_association" "example" {
  for_each = toset(var.account_ids)

  principal          = each.key
  resource_share_arn = var.resource_share_arn
}
