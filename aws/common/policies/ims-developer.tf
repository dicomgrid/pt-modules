data "aws_iam_policy_document" "ims_developer_override" {
  statement {
    sid    = "IAM"
    effect = "Allow"
    not_resources = [
      "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/*",
      "arn:aws:iam::*:role/cross_account_admin"
    ]
    actions = [
      "iam:AddClientIDToOpenIDConnectProvider",
      "iam:AddRoleToInstanceProfile",
      "iam:AttachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:CreateInstanceProfile",
      "iam:CreateOpenIDConnectProvider",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:CreateServiceLinkedRole",
      "iam:DeleteInstanceProfile",
      "iam:DeleteOpenIDConnectProvider",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DeleteServiceLinkedRole",
      "iam:DeleteUserPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:Get*",
      "iam:List*",
      "iam:PassRole",
      "iam:PutRolePolicy",
      "iam:RemoveClientIDFromOpenIDConnectProvider",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:Tag*",
      "iam:Untag*",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateOpenIDConnectProviderThumbprint",
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
    ]
  }
}

data "aws_iam_policy_document" "ims_developer" {
  source_policy_documents   = [data.aws_iam_policy_document.support_billing.json]
  override_policy_documents = [data.aws_iam_policy_document.ims_developer_override.json]
}

output "ims_developer" {
  value = data.aws_iam_policy_document.ims_developer.json
}
