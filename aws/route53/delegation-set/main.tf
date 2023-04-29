resource "aws_route53_delegation_set" "main" {
  reference_name = var.tags.Name
}

output "delegation_set" {
  value = aws_route53_delegation_set.main
}