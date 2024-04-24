resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  type    = var.type
  ttl     = var.ttl
  records = var.records
  name    = var.name
}