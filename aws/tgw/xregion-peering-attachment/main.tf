resource "aws_ec2_transit_gateway_peering_attachment" "main" {
  peer_account_id         = var.accepter_account_id
  peer_region             = var.accepter_region
  peer_transit_gateway_id = var.accepter_transit_gateway_id
  transit_gateway_id      = var.requester_transit_gateway_id
  tags = merge(local.tags, {
    Name      = "${var.requester_transit_gateway}-to-${var.accepter_transit_gateway}-peering",
    Requester = var.requester_transit_gateway,
    Accepter  = var.accepter_transit_gateway,
    Side      = "requester",
  })
}
