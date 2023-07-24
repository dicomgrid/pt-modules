resource "aws_dx_gateway_association" "association" {
  dx_gateway_id     = var.dx_gateway_id
  associated_gateway_id =var.associated_gateway_id
  allowed_prefixes = ["var.allowed_prefixes"]
}
