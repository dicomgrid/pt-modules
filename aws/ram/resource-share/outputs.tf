output "allow_external_principals" { value = aws_ram_resource_share.main.allow_external_principals }
output "arn" { value = aws_ram_resource_share.arn }
output "id" { value = aws_ram_resource_share.main.id }
output "name" { value = aws_ram_resource_share.main.name }
output "permission_arns" { value = aws_ram_resource_share.main.permission_arns }
output "principal_associations" { value = try( module.principal_association, null) }
output "resource_associations" { value = try( module.resource_association, null) }
output "tags" { value = aws_ram_resource_share.main.tags }
