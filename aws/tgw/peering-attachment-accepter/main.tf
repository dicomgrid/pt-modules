resource "aws_ec2_transit_gateway_peering_attachment_accepter" "main" {
  transit_gateway_attachment_id = var.transit_gateway_attachment_id
  tags = merge(local.tags, {
    Name      = "${var.requester_transit_gateway}-to-${var.accepter_transit_gateway}-peering",
    Requester = var.requester_transit_gateway,
    Accepter  = var.accepter_transit_gateway,
    Side      = "accepter",
  })
}

data "aws_ec2_transit_gateway" "main" {
  id = aws_ec2_transit_gateway_peering_attachment_accepter.main.transit_gateway_id
}

resource "aws_ec2_transit_gateway_route" "main" {
  for_each = toset(var.accepter_routes)

  destination_cidr_block         = each.value
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.main.id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway.main.association_default_route_table_id
}