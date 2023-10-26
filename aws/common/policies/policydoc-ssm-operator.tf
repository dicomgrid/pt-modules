data "aws_iam_policy_document" "policydoc-ssm-operator" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:SendCommand",
      "ssm:CancelCommand",
      "ssm:ListCommands",
      "ssm:ListCommandInvocations",
      "ssm:GetCommandInvocation",
      "ssm:GetAutomationExecution",
      "ssm:StartAutomationExecution",
      "ssm:ListTagsForResource",
      "ssm:GetParameters",
      "ssm:GetMaintenanceWindow*",
      "ssm:DescribePatch*",
      "ssm:GetPatch*",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "states:DescribeExecution",
      "states:StartExecution",
    ]
    resources = [
      "arn:aws:states:*:*:execution:*:*",
      "arn:aws:states:*:*:stateMachine:*",
    ]
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
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:*:*:function:SSM*",
      "arn:aws:lambda:*:*:function:*:SSM*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "states:DescribeExecution",
      "states:StartExecution",
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
      "iam:PassRole",
    ]
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values = [
        "ssm.amazonaws.com",
      ]
    }
  }
}

output "policydoc-ssm-operator" {
  value = data.aws_iam_policy_document.policydoc-ssm-operator.json
}