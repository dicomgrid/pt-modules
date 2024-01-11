output "arn" {
  value = aws_lb_target_group.main.arn
  #value = { for k,v in aws_lb_target_group.main : k => v.arn}
}
