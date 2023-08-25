output "arn" {
  value = aws_vpc.main.arn
}

output "id" {
  value = aws_vpc.main.id
}

output "instance_tenancy" {
  value = aws_vpc.main.instance_tenancy
}

output "enable_dns_support" {
  value = aws_vpc.main.enable_dns_support
}

output "enable_network_address_usage_metrics" {
  value = aws_vpc.main.enable_network_address_usage_metrics
}

output "enable_dns_hostnames" {
  value = aws_vpc.main.enable_dns_hostnames
}

# output "enable_classiclink" {
#   value = aws_vpc.main.enable_classiclink
# }

output "main_route_table_id" {
  value = aws_vpc.main.main_route_table_id
}

output "default_network_acl_id" {
  value = aws_vpc.main.default_network_acl_id
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}

output "default_route_table_id" {
  value = aws_vpc.main.default_route_table_id
}

output "ipv6_association_id" {
  value = aws_vpc.main.ipv6_association_id
}

output "ipv6_cidr_block_network_border_group" {
  value = aws_vpc.main.ipv6_cidr_block_network_border_group
}

output "owner_id" {
  value = aws_vpc.main.owner_id
}

output "tags_all" {
  value = aws_vpc.main.tags_all
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "ipv4_ipam_pool_id" {
  value = aws_vpc.main.ipv4_ipam_pool_id
}

output "ipv4_netmask_length" {
  value = aws_vpc.main.ipv4_netmask_length
}

output "ipv6_cidr_block" {
  value = aws_vpc.main.ipv6_cidr_block
}

output "ipv6_ipam_pool_id" {
  value = aws_vpc.main.ipv6_ipam_pool_id
}

output "ipv6_netmask_length" {
  value = aws_vpc.main.ipv6_netmask_length
}

output "assign_generated_ipv6_cidr_block" {
  value = aws_vpc.main.assign_generated_ipv6_cidr_block
}
