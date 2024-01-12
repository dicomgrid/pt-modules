output "arn" {
  value = aws_lb.main.arn
}

output "arn_suffix" {
  value = aws_lb.main.arn_suffix
}

output "dns_name" {
  value = aws_lb.main.dns_name
}

output "listener_arn" {
  value = { for k, v in aws_lb_listener.main : k => v.arn }
}

output "target_group" {
  value = { for k, v in module.target_group : k => v }
}

output "zone_id" {
  value = aws_lb.main.zone_id
}
