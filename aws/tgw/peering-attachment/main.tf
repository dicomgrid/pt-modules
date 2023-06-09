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

data "aws_ec2_transit_gateway" "main" {
  id = var.requester_transit_gateway_id
}

data "aws_ec2_transit_gateway_attachment" "main" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.main.id
}

resource "aws_ec2_transit_gateway_route" "main" {
  for_each = data.aws_ec2_transit_gateway_attachment.main.state == "available" ? toset(var.requester_routes) : []

  destination_cidr_block         = each.value
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.main.id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway.main.association_default_route_table_id
}