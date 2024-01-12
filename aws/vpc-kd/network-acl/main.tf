resource "aws_network_acl" "main" {
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      action          = ingress.value.action
      cidr_block      = try(ingress.value.cidr_block, null)
      from_port       = ingress.value.from_port
      icmp_code       = try(ingress.value.icmp_code, null)
      icmp_type       = try(ingress.value.icmp_type, null)
      ipv6_cidr_block = try(ingress.value.ipv6_cidr_block, null)
      protocol        = ingress.value.protocol
      rule_no         = ingress.value.rule_no
      to_port         = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      action          = egress.value.action
      cidr_block      = try(egress.value.cidr_block, null)
      from_port       = egress.value.from_port
      icmp_code       = try(egress.value.icmp_code, null)
      icmp_type       = try(egress.value.icmp_type, null)
      ipv6_cidr_block = try(egress.value.ipv6_cidr_block, null)
      protocol        = egress.value.protocol
      rule_no         = egress.value.rule_no
      to_port         = egress.value.to_port
    }
  }
  tags = var.tags
}

resource "aws_network_acl_rule" "main" {
  for_each        = merge([for type, type_value in var.rules : { for rule, rule_value in type_value : "${type}_${rule}" => merge(rule_value, { direction = type, rule_key = rule }) }]...)
  network_acl_id  = aws_network_acl.main.id
  rule_number     = try(each.value.rule_number, each.value.rule_key)
  egress          = each.value.direction == "egress" ? true : false
  protocol        = each.value.protocol
  rule_action     = each.value.rule_action
  cidr_block      = try(each.value.cidr_block, null)
  ipv6_cidr_block = try(each.value.ipv6_cidr_block, null)
  from_port       = try(each.value.from_port, null)
  to_port         = try(each.value.to_port, null)
  icmp_type       = try(each.value.icmp_type, null)
  icmp_code       = try(each.value.icmp_code, null)
}
