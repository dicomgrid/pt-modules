resource "aws_route53_zone" "zone" {
  name = var.tags.name
  tags = var.tags
}