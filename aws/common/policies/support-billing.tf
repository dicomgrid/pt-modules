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
      "account:GetAccountInformation",
      "billing:Get*",
      "ce:Describe*",
      "ce:Get*",
      "ce:List*",
      "consolidatedbilling:Get*",
      "consolidatedbilling:List*",
      "cur:Get*",
      "cur:Validate*",
      "freetier:Get*",
      "invoicing:Get*",
      "invoicing:List*",
      "payments:Get*",
      "payments:List*",
      "support:*",
      "tax:Get*",
      "tax:List*",
    ]
  }
}

output "support_billing" {
  value = data.aws_iam_policy_document.support_billing.json
}