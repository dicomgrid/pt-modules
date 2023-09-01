resource "aws_vpc_dhcp_options" "main" {
  domain_name          = var.domain_name == "" ? null : var.domain_name
  domain_name_servers  = var.domain_name_servers == [] ? null : var.domain_name_servers
  ntp_servers          = var.ntp_servers == [] ? null : var.ntp_servers
  netbios_name_servers = var.netbios_name_servers == [] ? null : var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type == null ? null : var.netbios_node_type

  tags = var.tags
}