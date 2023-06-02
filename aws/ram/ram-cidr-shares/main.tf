

provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}

locals {
  filtered_subnets = { for s in data.aws_subnet.example : s.id => s if contains(s.tags["Name"], "platform") }
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

module "principal_association" {
  source             = "git::ssh://git@github.com/dicomgrid/pt-modules.git//aws/ram/principal_association?ref=master"
  account_ids        = var.account_ids
  resource_share_arn = aws_ram_resource_share.example.arn
}
