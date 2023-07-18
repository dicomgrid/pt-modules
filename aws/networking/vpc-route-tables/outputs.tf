output "route_table_id" {
  value       = aws_route_table.rt.id
  description = "The ID of the created route table"
}

output "route_table_associations_ids" {
  value       = aws_route_table_association.a[*].id
  description = "The IDs of the created route table associations"
}