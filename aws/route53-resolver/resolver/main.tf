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
