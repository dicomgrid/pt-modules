resource "aws_ec2_transit_gateway_peering_attachment_accepter" "main" {
  transit_gateway_attachment_id = var.transit_gateway_attachment_id
  tags = merge(local.tags, {
    Name      = "${var.requester_transit_gateway}-to-${var.accepter_transit_gateway}-peering",
    Requester = var.requester_transit_gateway,
    Accepter  = var.accepter_transit_gateway,
    Side      = "accepter",
  })
}