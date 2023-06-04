
output "dx_gateway_id" {
  value = concat(aws_dx_gateway.this.*.id, [""])[0]
}

output "dx_gateway_name" {
  value = concat(aws_dx_gateway.this.*.name, [""])[0]
}
output "account_id" {
  description = "The AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}