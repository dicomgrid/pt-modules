output "id" {
  value = aws_nat_gateway.main.id
}
output "network_interface_id" {

  value = aws_nat_gateway.main.network_interface_id
}
output "public_ip" {

  value = aws_nat_gateway.main.public_ip
}
output "tags_all" {
  value = aws_nat_gateway.main.tags_all
}
output "subnet_id" {
  value = aws_nat_gateway.main.subnet_id
}
output "allocation_id" {
  value = aws_nat_gateway.main.allocation_id
}
output "connectivity_type" {
  value = aws_nat_gateway.main.connectivity_type
}
output "private_ip" {
  value = aws_nat_gateway.main.private_ip
}

output "availability_zone" {
  value = var.availability_zone
}