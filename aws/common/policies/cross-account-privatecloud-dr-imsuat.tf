data "aws_iam_policy_document" "cross_account_privatecloud_dr_imsuat" {
  statement {
    sid    = "s3WriteOnceReadMany"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
    ]
    resources = ["arn:aws:s3:::imsuat-privatecloud-dr-bucket"]
  }
}
