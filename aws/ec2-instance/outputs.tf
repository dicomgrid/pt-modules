output "availability_zone" {
  value = aws_instance.main.availability_zone
}

output "id" {
  value = aws_instance.main.id
}

output "private_ip" {
  value = aws_instance.main.private_ip
}

output "public_ip" {
  value = aws_instance.main.public_ip
}