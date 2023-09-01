resource "aws_vpc" "main" {
  cidr_block                           = var.cidr_block == "" ? null : var.cidr_block
  instance_tenancy                     = var.instance_tenancy == "" ? null : var.instance_tenancy
  ipv4_ipam_pool_id                    = var.ipv4_ipam_pool_id == "" ? null : var.ipv4_ipam_pool_id
  ipv4_netmask_length                  = var.ipv4_netmask_length == "" ? null : var.ipv4_netmask_length
  ipv6_cidr_block                      = var.ipv6_cidr_block == "" ? null : var.ipv6_cidr_block
  ipv6_ipam_pool_id                    = var.ipv6_ipam_pool_id == "" ? null : var.ipv6_ipam_pool_id
  ipv6_netmask_length                  = var.ipv6_netmask_length == "" ? null : var.ipv6_netmask_length
  ipv6_cidr_block_network_border_group = var.ipv6_cidr_block_network_border_group == "" ? null : var.ipv6_cidr_block_network_border_group
  enable_dns_support                   = var.enable_dns_support == "" ? null : var.enable_dns_support
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics == "" ? null : var.enable_network_address_usage_metrics
  enable_dns_hostnames                 = var.enable_dns_hostnames == "" ? null : var.enable_dns_hostnames
  enable_classiclink                   = var.enable_classiclink == "" ? null : var.enable_classiclink
  enable_classiclink_dns_support       = var.enable_classiclink_dns_support == "" ? null : var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block == "" ? null : var.assign_generated_ipv6_cidr_block

  tags = var.tags
}