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

# Create the S3 Object Manager role that can carry out the S3 Object Management policy
resource "aws_iam_role" "s3_object_manager_main" {
  depends_on = [
    aws_iam_policy.s3_object_management_main
  ]
  name     = "S3ObjectManager"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "AWS": "arn:aws:iam::${var.primary_account}:role/${var.instance_role}"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.s3_object_management_main.arn
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



# Create the S3 Object Management policy that allows the storage engines to manage objects once it assumes the S3ObjectManager role. 
resource "aws_iam_policy" "s3_object_management_main" {

  name        = "S3ObjectManagement"
  description = "Allow storage engines access to s3 objects"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "S3ObjectManagement",
        "Effect" : "Allow",
        "Action" : [
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
        ],
        "Resource" : "*"
      }
    ]
  })
}
