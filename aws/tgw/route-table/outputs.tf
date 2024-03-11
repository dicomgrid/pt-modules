output "arn" { value = try(aws_ec2_transit_gateway_route_table.main[0].arn, null) }
output "id" { value = try(aws_ec2_transit_gateway_route_table.main[0].id, null) }
