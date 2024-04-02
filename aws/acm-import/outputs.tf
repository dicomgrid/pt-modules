output "acm_arn" {
  value = aws_acm_certificate.main.arn
}

output "acm_domain" {
  value = aws_acm_certificate.main.domain_name
}
