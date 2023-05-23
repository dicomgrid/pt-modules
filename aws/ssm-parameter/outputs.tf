output "arn" {
  value = aws_ssm_parameter.main.arn
}

output "tags_all" {
  value = aws_ssm_parameter.main.tags_all
}

output "version" {
  value = aws_ssm_parameter.main.version
}