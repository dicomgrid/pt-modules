resource "aws_route53_delegation_set" "main" {
  reference_name = local.tags.Name
}

output "output" {
  value = aws_route53_delegation_set.main
}