resource "aws_nat_gateway" "main" {
  subnet_id         = var.subnet_id
  allocation_id     = var.allocation_id == "" ? null : var.allocation_id
  connectivity_type = var.connectivity_type == "" ? null : var.connectivity_type
  # private_ip        = var.private_ip == "" ? null : var.private_ip
  tags = var.tags
}