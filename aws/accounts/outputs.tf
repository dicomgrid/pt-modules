output "ou_map" { value = local.ou_map }
output "name" { value = aws_organizations_account.account.name }
output "email" { value = aws_organizations_account.account.email }
output "close_on_deletion" { value = aws_organizations_account.account.close_on_deletion }
output "role_name" { value = aws_organizations_account.account.role_name }
output "arn" { value = aws_organizations_account.account.arn }
output "id" { value = aws_organizations_account.account.id }
output "tags" { value = aws_organizations_account.account.tags_all }
