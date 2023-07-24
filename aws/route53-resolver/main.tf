module "endpoint_info" {
  source = "../common/vpc-subnet-id-per-az-lookup"

  subnets_filter = var.subnets_filter
  vpc_name       = var.vpc_name
}

module "security_group" {
  source = "../security-group"

  description = try(var.security_group.description, null)
  vpc_name    = var.vpc_name
  ingress     = var.security_group.ingress
  egress      = try(var.security_group.egress, var.egress_default)
  tags        = merge(var.tags, try(var.security_group.tags, {}), { Name = "${var.endpoint_name}-sg" })
}

resource "aws_route53_resolver_endpoint" "outbound" {
  count     = var.direction == "OUTBOUND" ? 1 : 0
  name      = var.endpoint_name
  direction = var.direction

  security_group_ids = var.security_group_ids
  dynamic "ip_address" {
    for_each = var.subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }

  tags = local.tags
}

module "rules" {
  source               = "./rules"
  for_each             = var.rules
  dns_server_ips       = each.value.dns_server_ips
  domain_name          = each.value.domain_name
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound[0].id
  rule_type            = each.value.rule_type
  vpc_id               = var.vpc_id
  tags                 = local.tags
}
