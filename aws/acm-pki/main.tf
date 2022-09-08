resource "aws_acm_certificate" "pkiname" {
domain_name = var.domain
subject_alternative_names = var.sans
validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "pkiname" {
  name         = "pt.intelerad.com"
  private_zone = false
}
resource "aws_route53_record" "pkiname" {
  for_each = {
    for dvo in aws_acm_certificate.pkiname.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.pkiname.zone_id
  allow_overwrite = var.allow_overwrite
}

resource "aws_acm_certificate_validation" "pkiname" {
  certificate_arn         = aws_acm_certificate.pkiname.arn
  validation_record_fqdns = [for record in aws_route53_record.pkiname : record.fqdn]
}















