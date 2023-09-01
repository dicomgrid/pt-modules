resource "aws_vpc_ipv4_cidr_block_association" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_association
}