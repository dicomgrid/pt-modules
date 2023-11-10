resource "aws_ram_resource_share" "main" {
  allow_external_principals = var.allow_external_principals
  name                      = var.name
  permission_arns = var.permission_arns
  tags = local.tags
}

module "resource_association" {
    source = "../resource-association"

    for_each = toset(var.resource_associations)
    resource_share_arn = aws_ram_resource_share.main.arn
    resource_arns = each.value
}

module "principal_association" {
    source = "../principal-association"

    for_each = toset(var.principal_associations)
    resource_share_arn = aws_ram_resource_share.main.arn
    principals = each.value
}
