locals {
  shared_aws_accounts = distinct(flatten([
    for subnet in var.vpc-details.vpc_subnets : [
      for account_id in try(subnet.shared_accounts, []) : [
        account_id
      ]
    ]
  ]))

  subnet_env_map = { for sb in var.vpc-details.vpc_subnets : sb.subnet_name =>
    length(regexall("-dev-", sb.subnet_name)) > 0 ? "dev" :
    length(regexall("-dev-", sb.subnet_name)) > 0 ? "qa" :
    length(regexall("-dev-", sb.subnet_name)) > 0 ? "uat" : "prod"
  }

  resource-share-arns = { for account_id in local.shared_aws_accounts : account_id => aws_ram_resource_share.main[account_id].arn }

  vpc_availability_zones = distinct(flatten([
    for subnet in var.vpc-details.vpc_subnets : [
      subnet.availability_zone
    ]
  ]))

  vpc_availability_zone_to_nat_gateway_subnet_map = { for sb in var.vpc-details.vpc_subnets : sb.availability_zone => sb.subnet_cidr_block if sb.nat_gateway == "true" && sb.map_public_ip_on_launch == "true" }
}

resource "aws_ram_resource_share" "main" {
  for_each                  = { for account_id in local.shared_aws_accounts : account_id => account_id }
  name                      = "resource-share-subnets-${var.vpc-details.vpc_name}-${each.key}"
  allow_external_principals = false

  tags = var.tags
}

resource "aws_ram_principal_association" "main" {
  for_each           = { for account_id in local.shared_aws_accounts : account_id => account_id }
  principal          = each.value
  resource_share_arn = aws_ram_resource_share.main[each.key].arn
}

module "vpc" {
  source                               = "./vpc"
  cidr_block                           = var.vpc-details.vpc_cidr_block
  enable_network_address_usage_metrics = try(var.vpc-details.enable_network_address_usage_metrics, null)
  tags                                 = merge(var.tags, { Name = var.vpc-details.vpc_name })
}

module "vpc_cidr_block_association" {
  source                 = "./vpc_cidr_block_association"
  for_each               = toset(lookup(var.vpc-details, "vpc_cidr_block_additionals", []))
  cidr_block_association = each.value
  vpc_id                 = module.vpc.id
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = module.vpc.id
  dhcp_options_id = var.dhcp-options-set-ids[var.vpc-details.dhcp-options-set]
}

module "vpc-subnets" {
  source                  = "./subnet"
  for_each                = { for sb in var.vpc-details.vpc_subnets : sb.subnet_cidr_block => sb }
  vpc_id                  = module.vpc.id
  cidr_block              = each.value["subnet_cidr_block"]
  availability_zone       = each.value["availability_zone"]
  map_public_ip_on_launch = each.value["map_public_ip_on_launch"]
  tags = merge(
    var.tags,
    {
      Name       = each.value["subnet_name"]
      Enviroment = local.subnet_env_map[each.value["subnet_name"]]
      SubnetType = length(regexall("-pri-", each.value["subnet_name"])) > 0 ? "private" : "public"
    },
    lookup(each.value, "tags", {})
  )
}

module "shared-vpc-subnets" {
  source              = "./shared-vpc-subnets"
  for_each            = { for sb in var.vpc-details.vpc_subnets : sb.subnet_cidr_block => sb }
  shared_account_ids  = try(each.value.shared_accounts, [])
  subnet_cidr_block   = each.value.subnet_cidr_block
  subnet_arn          = module.vpc-subnets[each.key].arn
  resource-share-arns = local.resource-share-arns
}

module "vpc-internet-gateway" {
  source = "./internet_gateway"
  vpc_id = module.vpc.id
  tags   = merge(var.tags, { Name = "${var.vpc-details.vpc_name}-internet-gateway" })

}

module "vpc-elastic-ip" {
  source   = "./eip"
  for_each = { for sb in var.vpc-details.vpc_subnets : sb.subnet_cidr_block => sb if sb.nat_gateway == "true" && sb.map_public_ip_on_launch == "true" }
  vpc      = true
  tags     = merge(var.tags, { Name = "${var.vpc-details.vpc_name}-${each.key}-elastic-ip" })

}

module "vpc-nat-gateway" {
  source            = "./nat_gateway"
  for_each          = { for sb in var.vpc-details.vpc_subnets : sb.subnet_cidr_block => sb if sb.nat_gateway == "true" && sb.map_public_ip_on_launch == "true" }
  subnet_id         = module.vpc-subnets[each.key].id
  availability_zone = each.value.availability_zone // This is used to map nat gw to specific route tables.
  allocation_id     = module.vpc-elastic-ip[each.key].allocation_id
  tags              = merge(var.tags, { Name = "vpc-${module.vpc.tags_all.Name}-${each.key}-nat-gateway" })

}

module "vpc-explicit-route-tables" {
  source              = "./vpc-route-table"
  for_each            = try(var.vpc-details.vpc_route_tables, {})
  tags                = var.tags
  vpc_id              = module.vpc.id
  vpc_name            = var.vpc-details.vpc_name
  route_table_name    = each.key
  route_table_details = each.value
  gateway_id          = module.vpc-internet-gateway.id
  nat_gateway_id      = try(each.value.nat_gateway_availability_zone, "") == "" ? null : module.vpc-nat-gateway[local.vpc_availability_zone_to_nat_gateway_subnet_map[try(each.value.nat_gateway_availability_zone, "")]].id
}

module "vpc-explicit-route-tables-associations" {
  source         = "./route_table_association"
  for_each       = { for sb in var.vpc-details.vpc_subnets : sb.subnet_cidr_block => sb if try(sb.route_table, "") != "" }
  route_table_id = module.vpc-explicit-route-tables[each.value["route_table"]].id
  subnet_id      = module.vpc-subnets[each.key].id
}
