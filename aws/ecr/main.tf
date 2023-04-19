resource "aws_ecr_repository" "main" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = local.tags
}

resource "aws_ecr_lifecycle_policy" "main" {
  count = var.lifecycle_policy == null ? 0 : 1
  repository = var.name
  policy = var.policy
}