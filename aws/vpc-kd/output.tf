# output "resource-share-arns" {
#   value = var.resource-share-arns
# }

# output "shared-subnets-by-account-id" {
#   value = local.shared-subnets-by-account-id
# }

# output "shared-subnets-list" {
#   value = var.shared-subnets-list
# }

output "shared_aws_accounts" {
  value = local.shared_aws_accounts
}