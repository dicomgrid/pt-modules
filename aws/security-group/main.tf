resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Application = lookup(var.tags, "application", "")
    Creator     = lookup(var.tags, "creator", "Terraform")
    Name        = var.name
    Owner       = lookup(var.tags, "owner", "Platform")
  }

  lifecycle {
    # Necessary if changing 'name' or 'name_prefix' properties.
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "main" {

  for_each = local.ruleset

  type        = var.direction
  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = var.subnets
  #ipv6_cidr_blocks = lookup(var.ingress.value, "subnets-v6", [])
  security_group_id = aws_security_group.main.id

}