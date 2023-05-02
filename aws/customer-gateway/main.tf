resource "aws_customer_gateway" "main" {
  bgp_asn    = var.asn
  ip_address = var.ip
  type       = var.type

  tags = local.tags
}