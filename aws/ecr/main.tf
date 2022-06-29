resource "aws_ecr_repository" "main" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = {
    Application = var.application
    Billing     = var.billing
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }
}