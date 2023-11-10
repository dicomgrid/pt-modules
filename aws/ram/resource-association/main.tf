resource "aws_ram_resource_association" "main" {
    for_each = toset(var.resource_arns)
    resource_arn       = each.value
    resource_share_arn = var.resource_share_arn
}
