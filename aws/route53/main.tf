resource "aws_route53_zone" "zone" {
  name = var.tags.Name
  tags = var.tags
}