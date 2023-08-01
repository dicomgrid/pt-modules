output "access_key_id" {
    value = try(aws_iam_access_key.main[0].id, null)
}

output "access_key_secret" {
    value = try(aws_iam_access_key.main[0].encrypted_secret, null)
}