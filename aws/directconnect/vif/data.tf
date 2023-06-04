data "aws_dx_router_configuration" "this" {
  virtual_interface_id   = aws_dx_hosted_transit_virtual_interface.transit[0].id
  router_type_identifier = var.route_type_identifier
}

data "aws_caller_identity" "current" {}
