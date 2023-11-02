data "aws_iam_policy_document" "ims_developer_billing" {
  statement {
    sid       = "IAMAccess"
    effect    = "Allow"
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
    sid       = "AllowedAllSerivces"
    effect    = "Allow"
    resources = ["*"]
    not_actions = [
      "iam:*",
      "organizations:*",
      "sts:Assume*",
    ]
  }

  statement {
    sid       = "Support"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "support:*",
    ]
  }

  statement {
    sid    = "DenyModifyOwnPolicyOrRole"
    effect = "Deny"
    actions = [
      "iam:UpdateRoleDescription",
      "iam:UpdateRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UntagRole",
      "iam:SetDefaultPolicyVersion",
      "iam:PutRolePolicy",
      "iam:PassRole",
      "iam:DetachRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:DeleteRole",
      "iam:DeletePolicyVersion",
      "iam:DeletePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreatePolicy",
      "iam:AttachRolePolicy"
    ]
    resources = [
      "arn:aws:iam::*:role/cross_account*",
      "arn:aws:iam::*:policy/sre-inf-developer"
    ]
  }

  statement {
    sid    = "updatedBillingActions"
    effect = "Allow"
    resources = [
      "ce:Get*",
      "ce:Describe*",
      "ce:List*",
      "account:GetAccountInformation",
      "billing:Get*",
      "payments:List*",
      "payments:Get*",
      "tax:List*",
      "tax:Get*",
      "consolidatedbilling:Get*",
      "consolidatedbilling:List*",
      "invoicing:List*",
      "invoicing:Get*",
      "cur:Get*",
      "cur:Validate*",
      "freetier:Get*"
    ]
  }
}

output "ims_developer_billing" {
  value = data.aws_iam_policy_document.ims_developer_billing.json
}
