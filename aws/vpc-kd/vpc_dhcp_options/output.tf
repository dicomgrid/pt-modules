output "domain_name" {
  value = var.domain_name
}
output "domain_name_servers" {
  value = var.domain_name_servers
}
output "ntp_servers" {
  value = var.ntp_servers
}
output "netbios_name_servers" {
  value = var.netbios_name_servers
}
output "netbios_node_type" {
  value = var.netbios_node_type
}
output "tags" {
  value = var.tags
}
output "id" {
  value = aws_vpc_dhcp_options.main.id
}
output "arn" {
  value = aws_vpc_dhcp_options.main.arn
}
output "owner_id" {
  value = aws_vpc_dhcp_options.main.owner_id
}
output "tags_all" {
  value = aws_vpc_dhcp_options.main.tags_all
}