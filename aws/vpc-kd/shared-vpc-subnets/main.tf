resource "aws_ram_resource_association" "main" {
  for_each           = { for account_id in var.shared_account_ids : "${var.subnet_cidr_block}:${account_id}" => account_id }
  resource_arn       = var.subnet_arn
  resource_share_arn = var.resource-share-arns[each.value]
}