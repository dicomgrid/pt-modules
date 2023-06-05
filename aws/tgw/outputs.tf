output "arn" { value = aws_ec2_transit_gateway.main.arn }
output "association_default_route_table_id" { value = aws_ec2_transit_gateway.main.association_default_route_table_id }
output "id" { value = aws_ec2_transit_gateway.main.id }
output "owner_id" { value = aws_ec2_transit_gateway.main.owner_id }
output "propagation_default_route_table_id" { value = aws_ec2_transit_gateway.main.propagation_default_route_table_id }
output "tags" { value = aws_ec2_transit_gateway.main.tags_all }