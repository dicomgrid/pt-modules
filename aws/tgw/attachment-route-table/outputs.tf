output "association_id" { value = try({ for k,v in aws_ec2_transit_gateway_route_table_association.main: k => v.id }, null) }
output "propagation_ids" { value = try({ for k,v in aws_ec2_transit_gateway_route_table_propagation.main: k => v.id }, null) }
