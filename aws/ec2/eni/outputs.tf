output "eni" {
  value = aws_network_interface.main
}

output "id" {
  value = aws_network_interface.main.id
}

output "eip" {
  value = { for k, v in aws_eip.main : k => v }
}
