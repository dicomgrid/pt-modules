resource "aws_route53_zone" "zone" {
  name = local.tags.Name
  delegation_set_id = var.delegation_set_id
  
  dynamic "vpc" {
    for_each = length(var.vpc_ids) > 0 ? var.vpc_ids : []
    content {
      vpc_id = vpc.value
    }
    
  }
  tags = local.tags
}

resource "aws_route53_record" "record" {
  for_each = var.records

  zone_id = aws_route53_zone.zone.zone_id
  name    = each.key
  type    = lookup(each.value, "type", "A")
  ttl     = lookup(each.value, "ttl", 300)
  records = each.value.destinations
}

output "vpc_ids" {
  value = var.vpc_ids
}

output "delegation_set_id" {
  value = var.delegation_set_id
}