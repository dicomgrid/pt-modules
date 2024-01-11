output "target_group_arn" {
  value = { for k, v in module.target_group : k => v.arn }
}
