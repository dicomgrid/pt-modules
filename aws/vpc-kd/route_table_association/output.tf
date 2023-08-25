output "id" {
  value = aws_route_table_association.main.id
}

output "route_table_id" {
  value = aws_route_table_association.main.route_table_id
}

output "subnet_id" {
  value = aws_route_table_association.main.subnet_id
}

output "gateway_id" {
  value = aws_route_table_association.main.gateway_id
}
