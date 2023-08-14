# Create the VPC attachment request
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {

  subnet_ids         = [for subnet_ids in local.az_subnets : subnet_ids[0]]
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id
  tags               = local.tags
}

# Create routes if any are needed to route traffic to the VPC
## A route for the VPC cidr is not needed as it is propagated by default
module "tgw_routes" {
  source = "../routes"

  for_each = var.tgw_routes

  routes            = each.value.routes
  tgw_id            = var.tgw_id
  tgw_attachment_id = aws_ec2_transit_gateway_vpc_attachment.main.id
  tgw_rtb_id        = try(each.value.tgw_rtb_id, null)
}

# Create routes if any are needed to route traffic back to the transit gateway
module "vpc_routes" {
  source = "../vpc-routes"

  for_each = var.vpc_routes

  routes              = each.value.routes
  subnets_tags_filter = try(each.value.subnets_tags_filter, null)
  vpc_id              = var.vpc_id
  tgw_id              = var.tgw_id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.main]
}
