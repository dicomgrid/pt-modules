output "id" {
  value = aws_ec2_transit_gateway_vpc_attachment.main.id
}
output "tags_all" {
  value = aws_ec2_transit_gateway_vpc_attachment.main.tags_all
}
output "vpc_owner_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.main.vpc_owner_id
}

output "vpc_routes" {
  value = module.vpc_routes
}

output "connect_attachments" {
  value = try(module.connect_attachments, null)
}
