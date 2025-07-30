output "gateway_instance_ids" {
  description = "List of TrustGrid gateway instance IDs"
  value       = [for k, v in aws_instance.trustgrid_gateways : v.id]
}
###
output "gateway_instance_map" {
  description = "Map of gateway instances by index"
  value       = aws_instance.trustgrid_gateways
}

output "gateway_public_ips" {
  description = "List of public IPs for TrustGrid gateways"
  value       = [for k, v in aws_eip.gateway_management : v.public_ip]
}

output "gateway_private_ips" {
  description = "List of private IPs for TrustGrid gateway management interfaces"
  value       = [for k, v in aws_network_interface.gateway_interfaces : v.private_ip if endswith(k, "-mgmt")]
}

output "gateway_data_private_ips" {
  description = "List of private IPs for TrustGrid gateway data interfaces"
  value       = [for k, v in aws_network_interface.gateway_interfaces : v.private_ip if endswith(k, "-data")]
}
##
output "gateway_names" {
  description = "List of TrustGrid gateway names"
  value       = local.gateway_names
}

output "cluster_name" {
  description = "TrustGrid cluster name"
  value       = var.enable_trustgrid_cluster ? tg_cluster.gateway_cluster[0].name : null
}

output "cluster_fqdn" {
  description = "TrustGrid cluster FQDN"
  value       = var.enable_trustgrid_cluster ? tg_cluster.gateway_cluster[0].fqdn : null
}

output "management_network_interface_ids" {
  description = "List of management network interface IDs"
  value       = [for k, v in aws_network_interface.gateway_interfaces : v.id if endswith(k, "-mgmt")]
}

output "data_network_interface_ids" {
  description = "List of data network interface IDs"
  value       = [for k, v in aws_network_interface.gateway_interfaces : v.id if endswith(k, "-data")]
}

output "management_security_group_id" {
  description = "Security group ID for management interfaces"
  value       = module.management_security_group.id
}

output "data_security_group_id" {
  description = "Security group ID for data interfaces"
  value       = module.data_security_group.id
}

output "iam_role_name" {
  description = "IAM role name for TrustGrid gateways"
  value       = local.iam_role_name
}



output "iam_instance_profile_name" {
  description = "IAM instance profile name for TrustGrid gateways"
  value       = local.iam_profile_name
}


output "shared_route_table_id" {
  description = "Shared route table ID for all private subnets (if using single route table)"
  value       = local.shared_route_table_id
}

output "managed_route_table_ids" {
  description = "List of route table IDs managed by TrustGrid"
  value       = local.managed_route_table_ids
}

output "vpc_id" {
  description = "VPC ID where gateways are deployed"
  value       = module.foundation.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = module.foundation.vpc_cidr_block
}

output "private_route_table_ids" {
  description = "All private route table IDs discovered"
  value       = local.private_route_table_ids
}

output "gateway_availability_zones" {
  description = "Availability zones where gateways are deployed"
  value       = var.availability_zones
}

output "gateway_node_ids" {
  description = "Map of TrustGrid node IDs by gateway index"
  value       = { for k, v in data.tg_node.registered_gateways : k => v.id }
}

output "gateway_subnet_assignments" {
  description = "Subnet assignments for each gateway"
  value       = local.gateway_subnet_assignments
}

output "gateway_network_config" {
  description = "Network configuration for each gateway"
  value       = local.gateway_network_config
}

output "gateway_data_ips" {
  description = "Data interface IPs for each gateway"
  value       = local.gateway_data_ips
}

output "gateway_lan_cidrs" {
  description = "LAN CIDRs for each gateway"
  value       = local.gateway_lan_cidrs
}

output "infrastructure_context" {
  description = "Complete infrastructure context from foundation module"
  value       = module.foundation.infrastructure
}

output "tags" {
  description = "Tags applied to resources"
  value       = module.foundation.tags
}

# Computed outputs for external use
output "active_gateway_public_ip" {
  description = "Public IP of the active gateway"
  value       = [for k, v in aws_eip.gateway_management : v.public_ip if local.gateway_matrix[k].cluster.is_active][0]
}

output "gateway_configuration" {
  description = "Complete gateway configuration matrix"
  value       = local.gateway_matrix
  sensitive   = true
}

