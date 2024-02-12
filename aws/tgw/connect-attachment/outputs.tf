output "id" { value = aws_ec2_transit_gateway_connect.main.id }
output "transport_attachment_id" { value = aws_ec2_transit_gateway_connect.main.transport_attachment_id }
output "peer" { value = { for k, v in aws_ec2_transit_gateway_connect_peer.main : k => v } }
