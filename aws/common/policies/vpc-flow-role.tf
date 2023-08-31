data "aws_iam_policy_document" "vpc-flow-role" {
  statement {
    sid    = ""
    effect = "Allow"
    resources = ["*"]
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
    ]
  }
}
output "vpc-flow-role" {
  value = data.aws_iam_policy_document.vpc-flow-role.json
}

