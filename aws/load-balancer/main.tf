resource "aws_lb" "main" {
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  internal                         = var.internal
  load_balancer_type               = var.load_balancer_type
  name                             = var.name
  security_groups                  = var.load_balancer_type == "application" ? data.aws_security_groups.main[0].ids : null
  subnets                          = data.aws_subnets.main.ids
  tags = {
    Application = var.application
    Billing     = var.billing
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }
}

resource "aws_lb_target_group" "main" {
  name     = var.name
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = data.aws_vpc.main.id

  dynamic "health_check" {
    for_each = var.health_check
    content {
      path                = lookup(health_check.value, "path" , null)
      port                = lookup(health_check.value, "port" , null)
      protocol            = lookup(health_check.value, "protocol" , null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold" , null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold" , null)
      timeout             = lookup(health_check.value, "timeout" , null)
      interval            = lookup(health_check.value, "interval" , null)
      matcher             = lookup(health_check.value, "matcher" , null)
    }
  }

  tags = {
    Application = var.application
    Billing     = var.billing
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.listener_action_type
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_target_group_attachment" "main" {
  for_each = toset(data.aws_instances.main.ids)

  target_group_arn = aws_lb_target_group.main.arn
  target_id        = each.key
  port             = var.target_port
}
