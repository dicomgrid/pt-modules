resource "aws_route53_resolver_rule" "main" {
  domain_name          = var.domain_name
  name                 = replace(var.domain_name, ".", "-dot-")
  rule_type            = var.rule_type
  resolver_endpoint_id = var.resolver_endpoint_id

  dynamic "target_ip" {
    for_each = var.dns_server_ips
    content {
      ip = target_ip.value
    }
  }

  tags = merge(local.tags, { Name = replace(var.domain_name, ".", "-dot-")})
}

resource "aws_route53_resolver_rule_association" "main" {
  resolver_rule_id = aws_route53_resolver_rule.main.id
  vpc_id           = var.vpc_id
}