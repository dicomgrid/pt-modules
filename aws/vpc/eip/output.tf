output "allocation_id" {
  value = aws_eip.main.allocation_id
}

output "association_id" {
  value = aws_eip.main.association_id
}

output "carrier_ip" {
  value = aws_eip.main.carrier_ip
}

output "customer_owned_ip" {
  value = aws_eip.main.customer_owned_ip
}

output "domain" {
  value = aws_eip.main.domain
}

output "id" {
  value = aws_eip.main.id
}

output "private_dns" {
  value = aws_eip.main.private_dns
}

output "private_ip" {
  value = aws_eip.main.private_ip
}

output "public_dns" {
  value = aws_eip.main.public_dns
}

output "public_ip" {
  value = replace(aws_eip.main.public_ip, "\\s+", "")
}

output "tags_all" {
  value = aws_eip.main.tags_all
}

output "address" {
  value = aws_eip.main.address
}

output "associate_with_private_ip" {
  value = aws_eip.main.associate_with_private_ip
}

output "customer_owned_ipv4_pool" {
  value = aws_eip.main.customer_owned_ipv4_pool
}

output "instance" {
  value = aws_eip.main.instance
}

output "network_border_group" {
  value = aws_eip.main.network_border_group
}

output "network_interface" {
  value = aws_eip.main.network_interface
}

output "public_ipv4_pool" {
  value = aws_eip.main.public_ipv4_pool
}


