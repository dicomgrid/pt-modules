resource "aws_ssm_parameter" "main" {
  name        = var.tags.Name
  type        = var.type
  value       = var.value
  description = var.description
  tier        = var.tier
  overwrite   = var.overwrite
  tags        = local.tags
}