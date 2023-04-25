resource "aws_security_group" "main" {
  name        = var.tags.name
  description = var.description
  vpc_id      = data.aws_vpc.main.id
  tags = var.tags

  lifecycle {
    # Necessary if changing 'name' or 'name_prefix' properties.
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "main" {
  for_each = local.rulesets

  type        = var.direction
  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = var.subnets
  #ipv6_cidr_blocks = lookup(var.ingress.value, "subnets-v6", [])
  security_group_id = aws_security_group.main.id
}