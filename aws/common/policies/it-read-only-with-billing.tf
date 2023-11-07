data "aws_iam_policy_document" "it_billing_readonly" {
  statement {
    sid       = "AllowBillingWithUsage"
    effect    = "Allow"
    resources = ["*"]
    actions = [
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
      "freetier:Get*",
    ]
  }
}

output "it_billing_readonly" {
  value = data.aws_iam_policy_document.it_billing_readonly.json
}
