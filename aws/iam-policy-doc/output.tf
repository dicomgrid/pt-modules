output "output" {
    value = data.aws_iam_policy_document.main[*].json
}