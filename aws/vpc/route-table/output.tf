output "id" {
  value = try(aws_route_table.main[0].id, null)
}
output "arn" {
  value = try(aws_route_table.main[0].arn, null)
}
output "owner_id" {
  value = try(aws_route_table.main[0].owner_id, null)
}
output "tags_all" {
  value = try(aws_route_table.main[0].tags_all, null)
}
output "vpc_id" {
  value = try(aws_route_table.main[0].vpc_id, null)
}
output "propagating_vgws" {
  value = try(aws_route_table.main[0].propagating_vgws, null)
}