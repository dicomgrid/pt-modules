output "subnet_flow_log_ids" {
  description = "The IDs of the subnet flow logs."
  value       = length(module.enable_subnet_logs) > 0 ? module.enable_subnet_logs[0].flow_log_ids : null
}
