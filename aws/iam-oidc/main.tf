data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  provider_url = replace(var.provider_url, "https://", "")

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
}


data "aws_iam_policy_document" "this" {
 

  statement {
    sid    = "GithubOidcAuth"
    effect = "Allow"
    actions = [
      "sts:TagSession",
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type        = "Federated"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.provider_url}"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "${local.provider_url}:aud"
      values   = [var.audience]
    }

    condition {
      test     = "StringLike"
      variable = "${local.provider_url}:sub"
      # Strip `repo:` to normalize for cases where users may prepend it
      values = [for subject in var.subjects : "repo:${trimprefix(subject, "repo:")}"]
    }
  }
}###
##
resource "aws_iam_role" "this" {


  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  description = var.description

  assume_role_policy    = data.aws_iam_policy_document.this.json
  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.policies : k => v  }

  role       = aws_iam_role.this.name
  policy_arn = each.value
}