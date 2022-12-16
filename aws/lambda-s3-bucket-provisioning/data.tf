# Existing AWS Managed Policy
# S3 Bucket Provisioning Service needs to be able to query organizations
# to find out which accounts are tagged as "ambra-storage"
data "aws_iam_policy" "AWSOrganizationsReadOnlyAccess" {
  provider = aws.primary
  name     = "AWSOrganizationsReadOnlyAccess"
}

# AWS Policy for allowing the lambda to assume the S3BucketManager role
# in each AWS Ambra Storage account
data "aws_iam_policy_document" "assume_s3_bucket_manager_in_sub_account_document" {
  provider = aws.primary
  for_each = var.ambra_storage_accounts
  statement {
    actions   = ["sts:assumeRole"]
    resources = formatlist("arn:aws:iam::%s:role/S3BucketManager", each.value)
  }

  statement {
    actions   = ["sts:GetAccessKeyInfo"]
    resources = ["*"]
  }
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

}

# Define the policy that allows Ambra storage to operate on the Ambra PHR storage bucket
data "aws_iam_policy_document" "ambra_phr_bucket_policy_document" {
  provider = aws.ambra_storage1_account
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.ambra_storage1_account}:root"]
    }

    actions = [
      "s3:DeleteObjectVersion",
      "s3:GetObjectVersionTagging",
      "s3:RestoreObject",
      "s3:GetObjectVersionAttributes",
      "s3:ReplicateObject",
      "s3:GetObjectVersionTorrent",
      "s3:GetObjectAcl",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:DeleteObject",
      "s3:PutObjectAcl",
      "s3:DeleteObjectTagging",
      "s3:GetObjectRetention",
      "s3:GetObjectAttributes",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectLegalHold",
      "s3:InitiateReplication",
      "s3:DeleteObjectVersionTagging",
      "s3:GetObjectLegalHold",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectTorrent",
      "s3:PutObjectRetention",
      "s3:PutObjectVersionAcl",
      "s3:GetObjectVersionForReplication",
      "s3:ReplicateDelete",
      "s3:GetObjectVersion",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetLifecycleConfiguration",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketTagging",
      "s3:GetInventoryConfiguration",
      "s3:GetBucketWebsite",
      "s3:ListBucketVersions",
      "s3:GetBucketLogging",
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:GetBucketAcl",
      "s3:GetBucketNotification",
      "s3:GetBucketPolicy",
      "s3:GetReplicationConfiguration",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetEncryptionConfiguration",
      "s3:GetIntelligentTieringConfiguration",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketCORS",
      "s3:GetMetricsConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::ambra-${var.environment}-${var.aws_region}-phr",
      "arn:aws:s3:::ambra-${var.environment}-${var.aws_region}-phr/*"
    ]
  }
}

data "aws_iam_policy_document" "ambra_orphan_bucket_policy_document" {
  provider = aws.ambra_storage1_account
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.ambra_storage1_account}:root"]
    }

    actions = [
      "s3:DeleteObjectVersion",
      "s3:GetObjectVersionTagging",
      "s3:RestoreObject",
      "s3:GetObjectVersionAttributes",
      "s3:ReplicateObject",
      "s3:GetObjectVersionTorrent",
      "s3:GetObjectAcl",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "s3:DeleteObject",
      "s3:PutObjectAcl",
      "s3:DeleteObjectTagging",
      "s3:GetObjectRetention",
      "s3:GetObjectAttributes",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectLegalHold",
      "s3:InitiateReplication",
      "s3:DeleteObjectVersionTagging",
      "s3:GetObjectLegalHold",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectTorrent",
      "s3:PutObjectRetention",
      "s3:PutObjectVersionAcl",
      "s3:GetObjectVersionForReplication",
      "s3:ReplicateDelete",
      "s3:GetObjectVersion",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetLifecycleConfiguration",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketTagging",
      "s3:GetInventoryConfiguration",
      "s3:GetBucketWebsite",
      "s3:ListBucketVersions",
      "s3:GetBucketLogging",
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:GetBucketAcl",
      "s3:GetBucketNotification",
      "s3:GetBucketPolicy",
      "s3:GetReplicationConfiguration",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetEncryptionConfiguration",
      "s3:GetIntelligentTieringConfiguration",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketCORS",
      "s3:GetMetricsConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::ambra-${var.environment}-${var.aws_region}-orphan",
      "arn:aws:s3:::ambra-${var.environment}-${var.aws_region}-orphan/*"
    ]
  }
}

##instance profile policy doc
data "aws_iam_policy_document" "s3-bucket-provisioning-instance-profile" {
  provider = aws.primary
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = ["arn:aws:lambda:${var.aws_region}:${var.primary_account}:function:${aws_lambda_function.s3_bucket_provisioning.function_name}"]
  }

  statement {
    actions   = ["lambda:InvokeFunctionUrl"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "lambda:FunctionUrlAuthType"
      values   = ["AWS_IAM"]
    }
    condition {
      test     = "ArnEquals"
      variable = "lambda:FunctionArn"
      values   = [
        "arn:aws:lambda:${var.aws_region}:${var.primary_account}:function:${aws_lambda_function.s3_bucket_provisioning.function_name}:*",
        "arn:aws:lambda:${var.aws_region}:${var.primary_account}:function:${aws_lambda_function.s3_bucket_provisioning.function_name}"
        ]
    }
  }
  statement {
    actions = [
      "cloudformation:DescribeStacks",
      "cloudformation:ListStackResources",
      "cloudwatch:GetMetricData",
      "cloudwatch:ListMetrics",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "kms:ListAliases",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListRolePolicies",
      "iam:ListRoles",
      "logs:DescribeLogGroups",
      "lambda:Get*",
      "lambda:List*",
      "states:DescribeStateMachine",
      "states:ListStateMachines",
      "tag:GetResources",
      "xray:GetTraceSummaries",
      "xray:BatchGetTraces"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*"]
  }

}
