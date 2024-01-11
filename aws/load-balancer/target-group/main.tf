resource "aws_lb_target_group" "main" {

  connection_termination             = var.connection_termination
  deregistration_delay               = var.deregistration_delay
  ip_address_type                    = var.ip_address_type
  lambda_multi_value_headers_enabled = var.lambda_multi_value_headers_enabled
  load_balancing_algorithm_type      = var.load_balancing_algorithm_type
  load_balancing_cross_zone_enabled  = var.load_balancing_cross_zone_enabled
  name                               = var.name
  name_prefix                        = var.name_prefix
  port                               = var.target_type == "lambda" ? null : var.port
  preserve_client_ip                 = var.preserve_client_ip
  protocol                           = var.target_type == "lambda" ? null : var.protocol
  protocol_version                   = var.protocol_version
  proxy_protocol_v2                  = var.proxy_protocol_v2
  slow_start                         = var.slow_start
  tags                               = merge(local.tags, { Name = "${var.name}" })
  target_type                        = var.target_type
  vpc_id                             = var.vpc_id

  dynamic "health_check" {
    for_each = var.health_check == {} ? [] : [var.health_check]

    content {
      enabled             = try(health_check.value.enabled, null)
      healthy_threshold   = try(health_check.value.healthy_threshold, null)
      interval            = try(health_check.value.interval, null)
      matcher             = try(health_check.value.matcher, null)
      path                = try(health_check.value.path, null)
      port                = try(health_check.value.port, null)
      protocol            = try(health_check.value.protocol, null)
      timeout             = try(health_check.value.timeout, null)
      unhealthy_threshold = try(health_check.value.unhealthy_threshold, null)
    }
  }

  dynamic "stickiness" {
    for_each = var.stickiness == {} ? [] : [var.stickiness]

    content {
      cookie_duration = try(stickiness.value.cookie_duration, null)
      cookie_name     = try(stickiness.value.cookie_name, null)
      enabled         = try(stickiness.value.enabled, true)
      type            = var.load_balancer_type == "network" ? "source_ip" : stickiness.value.type
    }
  }

  dynamic "target_failover" {
    for_each = var.target_failover == {} ? [] : [var.target_failover]

    content {
      on_deregistration = target_failover.value.on_deregistration
      on_unhealthy      = target_failover.value.on_unhealthy
    }
  }

  dynamic "target_health_state" {
    for_each = var.target_health_state == {} ? [] : [var.target_health_state]
    content {
      enable_unhealthy_connection_termination = try(target_health_state.value.enable_unhealthy_connection_termination, true)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "main" {
  for_each = { for v in var.attachments : v.target_id => v }

  target_group_arn  = aws_lb_target_group.main.arn
  target_id         = each.value.target_id
  port              = var.target_type == "lambda" ? null : try(each.value.port, var.port)
  availability_zone = try(each.value.availability_zone, null)
}
