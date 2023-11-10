output "id" { value = { for k, v in aws_ram_resource_association.main : k => v.id } }
output "resource_arn" { value = { for k, v in aws_ram_resource_association.main : k => v.resource_arn } }
output "resource_share_arn" { value = { for k, v in aws_ram_resource_association.main : k => v.resource_share_arn } }
