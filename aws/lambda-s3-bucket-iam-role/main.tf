# Create the S3 Bucket Manager role that can carry out the S3 Bucket Management policy
resource "aws_iam_role" "s3_bucket_manager_main" {
  depends_on = [
    aws_iam_policy.s3_bucket_management_main
  ]
  #provider = aws.storage_account
  name     = "S3BucketManager"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "AWS": "arn:aws:iam::${var.primary_account}:role/s3-bucket-provisioning-lambda-execution-role"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.s3_bucket_management_main.arn
  ]
}


# Create the S3 Bucket Management policy that allows the lambda to create buckets once it assumes the S3BucketManager role needs to be on each storage node
resource "aws_iam_policy" "s3_bucket_management_main" {
#  provider    = aws.storage-460460681175
  name        = "S3BucketManagement"
  description = "Allow S3 Bucket provisioning service to create buckets"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetBucketTagging",
          "s3:ListBucketVersions",
          "s3:GetBucketLogging",
          "s3:CreateBucket",
          "s3:ListBucket",
          "s3:GetBucketPolicy",
          "s3:GetBucketObjectLockConfiguration",
          "s3:PutBucketTagging",
          "s3:GetBucketRequestPayment",
          "s3:PutBucketAcl",
          "s3:GetBucketOwnershipControls",
          "s3:PutBucketVersioning",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetBucketPolicyStatus",
          "s3:ListBucketMultipartUploads",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetBucketWebsite",
          "s3:PutBucketOwnershipControls",
          "s3:GetBucketVersioning",
          "s3:PutBucketCORS",
          "s3:GetBucketAcl",
          "s3:GetBucketNotification",
          "s3:DeleteBucketPolicy",
          "s3:PutBucketNotification",
          "s3:PutBucketWebsite",
          "s3:ListAllMyBuckets",
          "s3:PutBucketRequestPayment",
          "s3:PutBucketLogging",
          "s3:GetBucketCORS",
          "s3:PutBucketPolicy",
          "s3:PutBucketObjectLockConfiguration",
          "s3:PutEncryptionConfiguration",
          "s3:GetBucketLocation",
          "s3:PutLifecycleConfiguration"
        ],
        "Resource" : "*"
      }
    ]
  })
}

