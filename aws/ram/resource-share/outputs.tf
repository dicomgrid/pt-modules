output "allow_external_principals" { value = aws_ram_resource_share.allow_external_principals }
output "arn" { value = aws_ram_resource_share.arn }
output "id" { value = aws_ram_resource_share.id }
output "name" { value = aws_ram_resource_share.name }
output "permission_arns" { value = aws_ram_resource_share.permission_arns }
output "principal_associations" { value = try( module.principal_association, null) }
output "resource_associations" { value = try( module.resource_association, null) }
output "tags" { value = aws_ram_resource_share.tags }
