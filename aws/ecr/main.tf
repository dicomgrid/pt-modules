resource "aws_ecr_repository" "main" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  encryption_configuration {
    encryption_type = var.kms_key == null ? "AES256" : "KMS"
    kms_key         = var.kms_key
  }
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = local.tags
}

resource "aws_ecr_lifecycle_policy" "main" {
  count = var.lifecycle_policy_enable == true ? 1 : 0
  repository = aws_ecr_repository.main.name
  policy = jsonencode(local.lifecycle_policy)
}

resource "aws_ecr_repository_policy" "main" {
  count      = local.permissions_create ? 1 : 0
  repository = aws_ecr_repository.main.name
  policy     = element(concat(data.aws_iam_policy_document.permissions[*].json, [""]), 0)
}