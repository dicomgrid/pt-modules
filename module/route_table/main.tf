# Create the route table
resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.route_table_name
    Environment = var.environment
    CodeManaged = var.code_managed
  }

dynamic "route" {
  for_each = var.routes
  
  content {
    cidr_block                = route.value.cidr_block
    gateway_id                = route.value.gateway_type == "igw" ? route.value.gateway_id : null
    destination_prefix_list_id = route.value.gateway_type == "pl" ? route.value.gateway_id : null
    ipv6_cidr_block           = route.value.gateway_type == "ipv6" ? route.value.gateway_id : null
    egress_only_gateway_id    = route.value.gateway_type == "egw" ? route.value.gateway_id : null
    nat_gateway_id            = route.value.gateway_type == "ngw" ? route.value.gateway_id : null
    network_interface_id      = route.value.gateway_type == "eni" ? route.value.gateway_id : null
    transit_gateway_id        = route.value.gateway_type == "tgw" ? route.value.gateway_id : null
    vpc_endpoint_id           = route.value.gateway_type == "vpce" ? route.value.gateway_id : null
    vpc_peering_connection_id = route.value.gateway_type == "vpcpc" ? route.value.gateway_id : null
  }
}

}
resource "aws_route_table_association" "a" {
  count          = var.subnet_ids != null ? length(var.subnet_ids) : 0
  subnet_id      = var.subnet_ids != null ? var.subnet_ids[count.index] : null
  route_table_id = aws_route_table.rt.id
}

# example module
# module "route_table" {
# source = "./module/route_table"
#
#   providers = {
#     aws = aws.platform-dev
#   }
#   vpc_id  = "vpc-0f393ffae034a0d32"
#   route_table_name = "terraform_route_table"
#   routes = [
#   
#     {
#       cidr_block = "172.15.15.1/32"
#       gateway_id = "tgw-0a5a811188514f5c1"
#     },
#     {
#       cidr_block = "172.15.16.2/32"
#       gateway_id = "tgw-0a5a811188514f5c1"
#       transit_gateway_id = "tgw-0a5a811188514f5c1"
#     }
#   ]
#   subnet_ids = []


