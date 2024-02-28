output "requester" {
  value = aws_ec2_transit_gateway_vpc_attachment.main
}

output "accepter" {
  value = aws_ec2_transit_gateway_vpc_attachment_accepter.main
}
