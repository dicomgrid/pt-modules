resource "aws_ram_resource_share" "main" {
  allow_external_principals = var.allow_external_principals
  name                      = var.name
  permission_arns = var.permission_arns
  tags = local.tags
}

module "resource_association" {
    source = "../resource-association"

    count = length(var.resource_arns) > 0 ? 1 : 0
    resource_arns = var.resource_arns
    resource_share_arn = aws_ram_resource_share.main.arn
}

module "principal_association" {
    source = "../principal-association"

    count = length(var.principals) > 0 ? 1 : 0
    principals = var.principals
    resource_share_arn = aws_ram_resource_share.main.arn
}
