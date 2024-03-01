output "id" {
  value = aws_route_table.main[0].id
}
output "arn" {
  value = aws_route_table.main[0].arn
}
output "owner_id" {
  value = aws_route_table.main[0].owner_id
}
output "tags_all" {
  value = aws_route_table.main[0].tags_all
}
output "vpc_id" {
  value = aws_route_table.main[0].vpc_id
}
output "propagating_vgws" {
  value = aws_route_table.main[0].propagating_vgws
}