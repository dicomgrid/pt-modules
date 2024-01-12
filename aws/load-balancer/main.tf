resource "aws_lb" "main" {
  customer_owned_ipv4_pool                                     = var.customer_owned_ipv4_pool
  desync_mitigation_mode                                       = var.desync_mitigation_mode
  dns_record_client_routing_policy                             = var.dns_record_client_routing_policy
  drop_invalid_header_fields                                   = var.drop_invalid_header_fields
  enable_cross_zone_load_balancing                             = var.enable_cross_zone_load_balancing
  enable_deletion_protection                                   = var.enable_deletion_protection
  enable_http2                                                 = var.enable_http2
  enable_tls_version_and_cipher_suite_headers                  = var.enable_tls_version_and_cipher_suite_headers
  enable_waf_fail_open                                         = var.enable_waf_fail_open
  enable_xff_client_port                                       = var.enable_xff_client_port
  enforce_security_group_inbound_rules_on_private_link_traffic = var.enforce_security_group_inbound_rules_on_private_link_traffic
  idle_timeout                                                 = var.idle_timeout
  internal                                                     = var.internal
  ip_address_type                                              = var.ip_address_type
  load_balancer_type                                           = var.load_balancer_type
  name                                                         = var.name
  name_prefix                                                  = var.name_prefix
  preserve_host_header                                         = var.preserve_host_header
  security_groups                                              = var.load_balancer_type == "application" ? var.security_groups : null
  subnets                                                      = var.subnets
  tags                                                         = local.tags
  xff_header_processing_mode                                   = var.xff_header_processing_mode

  dynamic "access_logs" {
    for_each = var.access_logs == {} ? [] : [var.access_logs]

    content {
      bucket  = access_logs.value.bucket
      enabled = try(access_logs.value.enabled, true)
      prefix  = try(access_logs.value.prefix, null)
    }
  }

  dynamic "connection_logs" {
    for_each = var.connection_logs == {} ? [] : [var.connection_logs]
    content {
      bucket  = connection_logs.value.bucket
      enabled = try(connection_logs.value.enabled, true)
      prefix  = try(connection_logs.value.prefix, null)
    }
  }

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping

    content {
      allocation_id        = lookup(subnet_mapping.value, "allocation_id", null)
      ipv6_address         = lookup(subnet_mapping.value, "ipv6_address", null)
      private_ipv4_address = lookup(subnet_mapping.value, "private_ipv4_address", null)
      subnet_id            = subnet_mapping.value.subnet_id
    }
  }

  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  lifecycle {
    ignore_changes = [
      tags["elasticbeanstalk:shared-elb-environment-count"]
    ]
  }

}


module "target_group" {
  source = "./target-group"

  for_each = var.target_groups

  attachments                        = try(each.value.attachments, [{}])
  connection_termination             = try(each.value.connection_termination, null)
  deregistration_delay               = try(each.value.deregistration_delay, null)
  health_check                       = try(each.value.health_check, {})
  ip_address_type                    = try(each.value.ip_address_type, null)
  lambda_multi_value_headers_enabled = try(each.value.lambda_multi_value_headers_enabled, null)
  load_balancer_type                 = var.load_balancer_type
  load_balancing_algorithm_type      = try(each.value.load_balancing_algorithm_type, null)
  load_balancing_anomaly_mitigation  = try(each.value.load_balancing_anomaly_mitigation, null)
  load_balancing_cross_zone_enabled  = try(each.value.load_balancing_cross_zone_enabled, null)
  name                               = try(each.value.name, "${var.name}-${each.key}")
  name_prefix                        = try(each.value.name_prefix, null)
  port                               = each.value.port
  preserve_client_ip                 = try(each.value.preserve_client_ip, null)
  protocol                           = each.value.protocol
  protocol_version                   = try(each.value.protocol_version, null)
  proxy_protocol_v2                  = try(each.value.proxy_protocol_v2, null)
  slow_start                         = try(each.value.slow_start, null)
  stickiness                         = try(each.value.stickiness, {})
  tags                               = merge(local.tags, { Name = try(each.value.name, "${var.name}-${each.key}"), LoadBalancer = var.name }, try(each.value.tags, {}))
  target_failover                    = try(each.value.target_failover, {})
  target_health_state                = try(each.value.target_health_state, {})
  target_type                        = try(each.value.target_type, "instance")
  vpc_id                             = var.vpc
}

resource "aws_lb_listener" "main" {
  for_each = var.listeners

  alpn_policy       = try(each.value.alpn_policy, null)
  certificate_arn   = try(each.value.certificate_arn, null)
  load_balancer_arn = aws_lb.main.arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = contains(["HTTPS", "TLS"], each.value.protocol) ? try(each.value.ssl_policy, "ELBSecurityPolicy-TLS13-1-2-2021-06") : null
  tags              = merge(local.tags, { Name = try(each.value.name, "${var.name}-${each.key}"), LoadBalancer = var.name }, try(each.value.tags, {}))

  dynamic "default_action" {
    for_each = try([each.value.authenticate_cognito], [])

    content {
      authenticate_cognito {
        authentication_request_extra_params = try(default_action.value.authentication_request_extra_params, null)
        on_unauthenticated_request          = try(default_action.value.on_unauthenticated_request, null)
        scope                               = try(default_action.value.scope, null)
        session_cookie_name                 = try(default_action.value.session_cookie_name, null)
        session_timeout                     = try(default_action.value.session_timeout, null)
        user_pool_arn                       = default_action.value.user_pool_arn
        user_pool_client_id                 = default_action.value.user_pool_client_id
        user_pool_domain                    = default_action.value.user_pool_domain
      }

      order = try(default_action.value.order, null)
      type  = "authenticate-cognito"
    }
  }

  dynamic "default_action" {
    for_each = try([each.value.authenticate_oidc], [])

    content {
      authenticate_oidc {
        authentication_request_extra_params = try(default_action.value.authentication_request_extra_params, null)
        authorization_endpoint              = default_action.value.authorization_endpoint
        client_id                           = default_action.value.client_id
        client_secret                       = default_action.value.client_secret
        issuer                              = default_action.value.issuer
        on_unauthenticated_request          = try(default_action.value.on_unauthenticated_request, null)
        scope                               = try(default_action.value.scope, null)
        session_cookie_name                 = try(default_action.value.session_cookie_name, null)
        session_timeout                     = try(default_action.value.session_timeout, null)
        token_endpoint                      = default_action.value.token_endpoint
        user_info_endpoint                  = default_action.value.user_info_endpoint
      }

      order = try(default_action.value.order, null)
      type  = "authenticate-oidc"
    }
  }

  dynamic "default_action" {
    for_each = try([each.value.fixed_response], [])

    content {
      fixed_response {
        content_type = default_action.value.content_type
        message_body = try(default_action.value.message_body, null)
        status_code  = try(default_action.value.status_code, null)
      }

      order = try(default_action.value.order, null)
      type  = "fixed-response"
    }
  }

  dynamic "default_action" {
    for_each = try([each.value.forward], [])

    content {
      order            = try(default_action.value.order, null)
      target_group_arn = length(try(default_action.value.target_groups, [])) > 0 ? null : try(default_action.value.target_group_arn, module.target_group[default_action.value.target_group].arn, null)
      type             = "forward"
    }
  }

  dynamic "default_action" {
    for_each = try([each.value.weighted_forward], [])

    content {
      forward {
        dynamic "target_group" {
          for_each = try(default_action.value.target_groups, [])

          content {
            arn    = try(target_group.value.arn, module.target_group[target_group.value.target_group].arn, null)
            weight = try(target_group.value.weight, null)
          }
        }

        dynamic "stickiness" {
          for_each = try([default_action.value.stickiness], [])

          content {
            duration = try(stickiness.value.duration, 60)
            enabled  = try(stickiness.value.enabled, null)
          }
        }
      }

      order = try(default_action.value.order, null)
      type  = "forward"
    }
  }

  dynamic "default_action" {
    for_each = try([each.value.redirect], [])

    content {
      order = try(default_action.value.order, null)

      redirect {
        host        = try(default_action.value.host, null)
        path        = try(default_action.value.path, null)
        port        = try(default_action.value.port, null)
        protocol    = try(default_action.value.protocol, null)
        query       = try(default_action.value.query, null)
        status_code = default_action.value.status_code
      }

      type = "redirect"
    }
  }

}
