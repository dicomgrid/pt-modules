resource "aws_lb" "main" {
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  internal                         = var.internal
  load_balancer_type               = var.load_balancer_type
  name                             = var.name
  security_groups                  = var.type == "application" ? data.aws_security_groups.main[0].ids : null
  subnets                          = data.aws_subnet_ids.main.ids

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
  port     = var.port
  protocol = var.protocol
  vpc_id   = data.aws_vpc.main.id

  dynamic "health_check" {
    for_each = var.health_check
    content {
      path                = health_check.value["path"]
      port                = health_check.value["port"]
      protocol            = health_check.value["protocal"]
      healthy_threshold   = health_check.value["healthy_threshold"]
      unhealthy_threshold = health_check.value["unhealthy_threshold"]
      timeout             = health_check.value["timeout"]
      interval            = health_check.value["interval"]
      matcher             = health_check.value["matcher"]
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
