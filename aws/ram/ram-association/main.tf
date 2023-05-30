variable "account_ids" {
  description = "The AWS Account ID numbers of the accounts with which you are sharing your subnet"
  type        = list(string)
}

variable "resource_share_arn" {
  description = "The ARN of the resource share"
  type        = string
}

resource "aws_ram_principal_association" "example" {
  for_each = toset(var.account_ids)

  principal          = each.key
  resource_share_arn = var.resource_share_arn
}