output "attachment" {
  value = aws_ec2_transit_gateway_peering_attachment.main
}

# output "attachment_state" {
#   value = data.aws_ec2_transit_gateway_attachment.main.state
# }