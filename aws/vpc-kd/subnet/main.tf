resource "aws_subnet" "main" {
  vpc_id                                         = var.vpc_id
  cidr_block                                     = var.cidr_block == "" ? null : var.cidr_block
  availability_zone                              = var.availability_zone == "" ? null : var.availability_zone
  customer_owned_ipv4_pool                       = var.customer_owned_ipv4_pool == "" ? null : var.customer_owned_ipv4_pool
  enable_dns64                                   = var.enable_dns64 == "" ? null : var.enable_dns64
  enable_resource_name_dns_aaaa_record_on_launch = var.enable_resource_name_dns_aaaa_record_on_launch == "" ? null : var.enable_resource_name_dns_aaaa_record_on_launch
  enable_resource_name_dns_a_record_on_launch    = var.enable_resource_name_dns_a_record_on_launch == "" ? null : var.enable_resource_name_dns_a_record_on_launch
  ipv6_cidr_block                                = var.ipv6_cidr_block == "" ? null : var.ipv6_cidr_block
  ipv6_native                                    = var.ipv6_native == "" ? null : var.ipv6_native
  map_customer_owned_ip_on_launch                = var.map_customer_owned_ip_on_launch == "" ? null : var.map_customer_owned_ip_on_launch
  map_public_ip_on_launch                        = var.map_public_ip_on_launch == "" ? null : var.map_public_ip_on_launch
  outpost_arn                                    = var.outpost_arn == "" ? null : var.outpost_arn
  private_dns_hostname_type_on_launch            = var.private_dns_hostname_type_on_launch == "" ? null : var.private_dns_hostname_type_on_launch


  tags = var.tags
}
