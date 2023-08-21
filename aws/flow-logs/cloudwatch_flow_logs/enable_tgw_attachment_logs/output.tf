output "tgw_attachment_flow_log_ids" {
  value = length(module.enable_tgw_attachment_logs) > 0 ? module.enable_tgw_attachment_logs[0].flow_log_ids : null
}
