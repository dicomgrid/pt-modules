output "arn" { value = aws_ec2_transit_gateway.main.arn }
output "association_default_route_table_id" { value = aws_ec2_transit_gateway.main.association_default_route_table_id }
output "id" { value = aws_ec2_transit_gateway.main.id }
output "owner_id" { value = aws_ec2_transit_gateway.main.owner_id }
output "propagation_default_route_table_id" { value = aws_ec2_transit_gateway.main.propagation_default_route_table_id }
output "route_table_id_map" { value = merge(try({ default = aws_ec2_transit_gateway.main.association_default_route_table_id }, {}), { for k, v in module.route_table : k => v.id }) }
output "tags" { value = aws_ec2_transit_gateway.main.tags_all }
