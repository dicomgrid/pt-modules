output "vpc_flow_log_ids" {
  description = "The IDs of the VPC flow logs."
  value       = aws_flow_log.enable_vpc_logs
}
