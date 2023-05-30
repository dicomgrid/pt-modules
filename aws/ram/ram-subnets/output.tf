output "filtered_subnets" {
  value = local.filtered_subnets
}

output "ram_resource_association" {
  value = aws_ram_resource_association.example
}

output "ram_principal_association" {
  value = aws_ram_principal_association.example
}