data "aws_iam_policy_document" "permissions" {
  count = local.permissions_create ? 1 : 0
  dynamic "statement" {
    for_each = local.permissions_read_write
    content {
      effect = "Allow"
      sid    = "ECRPushers"

      principals {
        type        = statement.key
        identifiers = statement.value
      }

      actions = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:BatchDeleteImage",
        "ecr:UploadLayerPart",
        "ecr:ListImages",
        "ecr:InitiateLayerUpload",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetRepositoryPolicy",
        "ecr:PutImage",
      ]
    }
  }

  dynamic "statement" {
    for_each = local.permissions_read_only
    content {
      effect = "Allow"

      sid = "ECRPullers"

      principals {
        type        = statement.key
        identifiers = statement.value
      }

      actions = [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:BatchCheckLayerAvailability",
      ]
    }
  }
}