resource "aws_route53_zone" "zone" {
  name = var.zone

  tags = {
    name        = var.zone
    environment = var.environment
    billing     = var.billing
    creator     = var.creator
  }

}