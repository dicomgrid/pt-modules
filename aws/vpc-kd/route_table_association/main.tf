resource "aws_route_table_association" "main" {
  route_table_id = var.route_table_id
  subnet_id      = var.subnet_id == "" ? null : var.subnet_id
  gateway_id     = var.gateway_id == "" ? null : var.gateway_id

}