output "id" { value = { for k,v in aws_ram_principal_association.main : k => v.id } }
output "principal" { value = { for k,v in aws_ram_principal_association.main : k => v.principal } }
output "resource_share_arn" { value = { for k,v in aws_ram_principal_association.main : k => v.resource_share_arn } }
