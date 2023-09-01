resource "aws_route_table" "main" {
  vpc_id           = var.vpc_id
  propagating_vgws = var.propagating_vgws == [] ? [] : var.propagating_vgws
  tags             = var.tags

}