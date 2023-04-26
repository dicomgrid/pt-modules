data "aws_iam_policy_document" "ims_developer" {
  statement {
    sid    = "IAM"
    effect = "Allow"
    not_resources = [
      "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/*",
      "arn:aws:iam::*:role/cross_account_admin"
    ]
    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:AttachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:CreateInstanceProfile",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:CreateServiceLinkedRole",
      "iam:DeleteInstanceProfile",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DeleteServiceLinkedRole",
      "iam:DeleteUserPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
      "iam:Get*",
      "iam:List*",
      "iam:PassRole",
      "iam:PutRolePolicy",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:TagInstanceProfile",
      "iam:tagPolicy",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:UntagPolicy",
      "iam:UntagRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
    ]
  }

  statement {
    sid       = "GrantAll"
    effect    = "Allow"
    resources = ["*"]
    not_actions = [
      "iam:*",
      "organizations:*",
      "sts:Assume*",
    ]
  }

  statement {
    sid       = "SupportBilling"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "aws-portal:ViewBilling",
      "aws-portal:ViewUsage",
      "support:*",
    ]
  }
}

output "ims_developer" {
  value = data.aws_iam_policy_document.ims_developer.json
}
