resource "aws_ssm_parameter" "server_code" {
  name        = "/server_metadata/${var.server_name}/server_code"
  type        = var.type
  value       = var.server_code
  description = var.description
  tier        = var.tier
}

resource "aws_ssm_parameter" "role" {
  name        = "/server_metadata/${var.server_name}/role"
  type        = var.type
  value       = var.role
  description = var.description
  tier        = var.tier
}

resource "aws_ssm_parameter" "product" {
  name        = "/server_metadata/${var.server_name}/product"
  type        = var.type
  value       = var.product
  description = var.description
  tier        = var.tier
}

