
resource "aws_networkmanager_transit_gateway_registration" "tgw_registration" {
  for_each            = toset(var.transit_gateways)
  global_network_id   = var.global_network_id
  transit_gateway_arn = format("arn:aws:ec2:%s:%s:transit-gateway/%s", var.region, var.aws_account_id, each.value)
}


