data "aws_network_interfaces" "enis" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


output "eni_ids" {
  description = "IDs of the network interfaces within the specified VPC"
  value       = [for eni in data.aws_network_interfaces.enis.ids : eni]
}
