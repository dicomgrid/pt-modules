output "arn" { value = try(aws_ec2_transit_gateway_route_table.main.arn, null) }
output "id" { value = try(aws_ec2_transit_gateway_route_table.main.id, null) }
