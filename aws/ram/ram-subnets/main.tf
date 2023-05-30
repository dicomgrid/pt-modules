data "aws_subnets" "example" {
  vpc_id = var.vpc_id
}

locals {
  filtered_subnets = { for s in data.aws_subnets.example.subnets : s.id => s if contains(s.tags["Name"], "platform") }
}

resource "aws_ram_resource_share" "example" {
  name                      = "example"
  allow_external_principals = true
}

resource "aws_ram_resource_association" "example" {
  for_each           = local.filtered_subnets
  resource_arn       = each.value.arn
  resource_share_arn = aws_ram_resource_share.example.arn
}

resource "aws_ram_principal_association" "example" {
  for_each = toset(var.account_ids)

  principal          = each.key
  resource_share_arn = var.resource_share_arn
}

module "principal_association" {
  source             = ""
  account_ids        = var.account_ids
  resource_share_arn = aws_ram_resource_share.example.arna

}