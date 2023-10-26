data "aws_iam_policy_document" "policydoc-ssm-readonly" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:DescribeInstanceProperties",
      "ssm:DescribeInstancePatchStates",
      "ssm:DescribeMaintenanceWindow*",
      "ssm:DescribePatch*",
      "ssm:GetCommandInvocation",
      "ssm:GetMaintenanceWindow*",
      "ssm:ListAssociations",
      "ssm:ListCommandInvocations",
      "ssm:ListCommands",
      "ssm:ListResourceComplianceSummaries",
      "ssm:GetAutomationExecution",
      "ssm:GetPatch*",
      "ssm:ListTagsForResource",
      "ssm:GetCalendarState",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstances",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "states:DescribeExecution",
    ]
    resources = [
      "arn:aws:states:*:*:stateMachine:SSM*",
      "arn:aws:states:*:*:execution:SSM*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "resource-groups:ListGroups",
      "resource-groups:ListGroupResources",
      "resource-groups:GetGroupQuery",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "tag:GetResources",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "support:DescribeTrustedAdvisorChecks",
      "support:DescribeTrustedAdvisorCheckSummaries",
      "support:DescribeTrustedAdvisorCheckResult",
      "support:DescribeCases",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "config:DescribeComplianceByConfigRule",
      "config:DescribeComplianceByResource",
      "config:DescribeRemediationConfigurations",
      "config:DescribeConfigurationRecorders",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "securityhub:DescribeHub",
    ]
    resources = ["*"]
  }
}

output "policydoc-ssm-readonly" {
  value = data.aws_iam_policy_document.policydoc-ssm-readonly.json
}