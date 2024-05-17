output "private_ip" {
  value = aws_eip.main.private_ip
}

output "public_ip" {
  value = aws_eip.main.public_ip
}
