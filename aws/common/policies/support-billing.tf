data "aws_iam_policy_document" "support_billing" {

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

  # https://aws.amazon.com/blogs/aws-cloud-financial-management/changes-to-aws-billing-cost-management-and-account-consoles-permissions/
  statement {
    sid       = "SupportBillingPendingMigration"
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
      "support:*",
    ]
  }
}

output "support_billing" {
  value = data.aws_iam_policy_document.support_billing.json
}