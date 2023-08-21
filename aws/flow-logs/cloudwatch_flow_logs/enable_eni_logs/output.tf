output "eni_flow_log_ids" {
  description = "The IDs of the ENI flow logs."
  value       = length(module.enable_eni_logs) > 0 ? module.enable_eni_logs.flow_log_ids : null
}
