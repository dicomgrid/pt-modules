# S3 bucket for storing Ambra PHR ("Personal Health Record") data
resource "aws_s3_bucket" "ambra_phr_bucket" {
  provider = aws.ambra_storage1_account
  bucket   = "ambra-${var.environment}-${var.aws_region}-phr"

  tags = {
    Name                     = "ambra-${var.environment}-${var.aws_region}-phr"
    Billing                  = "ambra phr"
    map-migrated             = "d-server-03bwvdqjri88ho"
    aws-migration-project-id = "MPE36510"
    Environment              = var.environment
    Owner                    = "platform"
    CodeManaged              = "true"
    Compliance               = "phi"
    Product                  = "ambra"
    OneTime                  = "null"
    Application              = "storage-lt"
  }
}

#enabling bucket versioning for Ambra PHR Account bucket
resource "aws_s3_bucket_versioning" "ambra_phr_bucket" {
  provider = aws.ambra_storage1_account
  bucket   = aws_s3_bucket.ambra_phr_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
# Lifecycle rules for ambra PHR bucket
resource "aws_s3_bucket_lifecycle_configuration" "ambra_phr_bucket" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.ambra_phr_bucket]
  provider   = aws.ambra_storage1_account
  bucket     = aws_s3_bucket.ambra_phr_bucket.id

  rule {
    id = "ExpireNonCurrentVersion"
    noncurrent_version_expiration {
      noncurrent_days = 3
    }
    expiration {
      expired_object_delete_marker = true
    }
    status = "Enabled"
  }
  rule {
    id = "AbortIncompleteMultipartUploads"
    abort_incomplete_multipart_upload {
      days_after_initiation = 2
    }
    status = "Enabled"
  }
}

# Encryption scheme for Ambra PHR bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "ambra_phr_bucket_encryption" {
  provider = aws.ambra_storage1_account
  bucket   = aws_s3_bucket.ambra_phr_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# S3 bucket for storing Orphaned PHR ("Personal Health Record") data
resource "aws_s3_bucket" "ambra_orphan_bucket" {
  provider = aws.ambra_storage1_account
  bucket   = "ambra-${var.environment}-${var.aws_region}-orphan"

  tags = {
    Name                     = "ambra-${var.environment}-${var.aws_region}-orphan"
    Billing                  = "ambra orphan"
    map-migrated             = "d-server-03bwvdqjri88ho"
    aws-migration-project-id = "MPE36510"
    Environment              = var.environment
    Owner                    = "platform"
    CodeManaged              = "true"
    Compliance               = "phi"
    Product                  = "ambra"
    OneTime                  = "null"
    Application              = "storage-lt"
  }
}

#enabling bucket versioning for Orphaned PHR ("Personal Health Record") bucket
resource "aws_s3_bucket_versioning" "ambra_orphan_bucket" {
  provider = aws.ambra_storage1_account
  bucket   = aws_s3_bucket.ambra_orphan_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle rules for Orphaned PHR bucket
resource "aws_s3_bucket_lifecycle_configuration" "ambra_orphan_bucket" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.ambra_orphan_bucket]
  provider   = aws.ambra_storage1_account
  bucket     = aws_s3_bucket.ambra_orphan_bucket.id

  rule {
    id = "ExpireNonCurrentVersion"
    noncurrent_version_expiration {
      noncurrent_days = 3
    }
    expiration {
      expired_object_delete_marker = true
    }
    status = "Enabled"
  }
  rule {
    id = "AbortIncompleteMultipartUploads"
    abort_incomplete_multipart_upload {
      days_after_initiation = 2
    }
    status = "Enabled"
  }
}

# Encryption scheme for Ambra Orphaned bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "ambra_orphan_bucket_encryption" {
  provider = aws.ambra_storage1_account
  bucket   = aws_s3_bucket.ambra_orphan_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# AWS Lambda for determining in which AWS account to create S3 bucket
resource "aws_lambda_function" "s3_bucket_provisioning" {
  provider      = aws.primary
  function_name = "s3-bucket-provisioning"
  filename      = "${path.module}/s3-bucket-provisioning-1.2.0-SNAPSHOT.jar"

  handler     = "com.ambrahealth.aws.lambda.S3BucketProvisioningHandler"
  role        = aws_iam_role.iam_for_s3_bucket_provisioning.arn
  runtime     = "java11"
  memory_size = 2048
  timeout     = var.timeout
  publish     = true

  snap_start {
    apply_on = "PublishedVersions"
  }
  environment {
    variables = {
      AMBRA_ENABLE_ACCESS_LOGGING   = "${var.access_logging}"
      AMBRA_ENVIRONMENT             = "${var.environment}"
      AMBRA_MAX_BUCKETS_PER_ACCOUNT = "${var.max_buckets_per_account}"
      AMBRA_REGION                  = "${var.aws_region}"
      AMBRA_PHR_ACCOUNT             = "${var.ambra_storage1_account}"
      AMBRA_PHR_BUCKET              = "ambra-${var.environment}-${var.aws_region}-phr"
      AMBRA_OBJECT_EXPIRATION_DAYS  = "${var.object_expiration}"
      AMBRA_ORPHAN_ACCOUNT          = "${var.ambra_storage1_account}"
      AMBRA_ORPHAN_BUCKET           = "ambra-${var.environment}-${var.aws_region}-orphan"
      AMBRA_STORAGE_ACCOUNTS        = "${join(",", [for s in var.ambra_storage_accounts : format("%q", s)])}"
    }
  }
  tags = {
    map-migrated             = "d-server-03bwvdqjri88ho"
    aws-migration-project-id = "MPE36510"
  }
}

###Creating alias for lambda function for function url call
resource "aws_lambda_alias" "lambda_alias" {
  provider         = aws.primary
  name             = "v${aws_lambda_function.s3_bucket_provisioning.version}"
  function_name    = aws_lambda_function.s3_bucket_provisioning.arn
  function_version = aws_lambda_function.s3_bucket_provisioning.version
}

# Create a function URL for the Lambda that avoids needing to setup a separate API Gateway
resource "aws_lambda_function_url" "s3_bucket_provisioning_url" {
  provider           = aws.primary
  function_name      = aws_lambda_function.s3_bucket_provisioning.function_name
  authorization_type = "AWS_IAM"
}

# Create a second function URL for the Lambda that uses alias name to leverage snap_start
resource "aws_lambda_function_url" "s3_bucket_provisioning_alias_url" {
  provider           = aws.primary
  function_name      = aws_lambda_function.s3_bucket_provisioning.function_name
  authorization_type = "AWS_IAM"
  qualifier          = aws_lambda_alias.lambda_alias.name
}

# Create the role that allows the Lambda to carry out its work
resource "aws_iam_role" "iam_for_s3_bucket_provisioning" {
  provider = aws.primary
  name     = var.lambda_execution_role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}


# Give the lambda role the right to assume the S3BucketManager role in each Ambra storage account
resource "aws_iam_role_policy_attachment" "s3_bucket_provisioning_assume_sub_account" {
  provider   = aws.primary
  for_each   = var.ambra_storage_accounts
  role       = aws_iam_role.iam_for_s3_bucket_provisioning.name
  policy_arn = aws_iam_policy.assume_s3_bucket_manager_in_sub_account[each.key].arn
}




# Create Assume S3 Bucket Manager policies, one per Ambra storage account
resource "aws_iam_policy" "assume_s3_bucket_manager_in_sub_account" {
  provider = aws.primary
  for_each = var.ambra_storage_accounts

  name        = "AssumeS3BucketManagerInSubAccount-${each.key}"
  description = "Allow S3 Bucket provisioning service to assume the S3BucketManager role in other AWS 'ambra storage' accounts"

  policy = data.aws_iam_policy_document.assume_s3_bucket_manager_in_sub_account_document[each.key].json
}


# Apply the Ambra PHR bucket policy to the Ambra PHR bucket
resource "aws_s3_bucket_policy" "ambra_phr_bucket_policy" {
  provider = aws.ambra_storage1_account
  bucket   = aws_s3_bucket.ambra_phr_bucket.id
  policy   = data.aws_iam_policy_document.ambra_phr_bucket_policy_document.json
}

# Apply the Ambra PHR bucket policy to the Ambra Orphaned bucket
resource "aws_s3_bucket_policy" "ambra_orphan_bucket_policy" {
  provider = aws.ambra_storage1_account
  bucket   = aws_s3_bucket.ambra_orphan_bucket.id
  policy   = data.aws_iam_policy_document.ambra_orphan_bucket_policy_document.json
}


### INSTANCE Profile for service nodes to use to invoke lambda
resource "aws_iam_role" "main" {
  provider           = aws.primary
  description        = "Allows EC2 instances to call AWS services on your behalf."
  name               = var.services_instance_profile_name
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": ["sts:AssumeRole","sts:TagSession"],
            "Principal": {
               "Service": [
                    "ec2.amazonaws.com",
                    "ssm.amazonaws.com",
                    "pods.eks.amazonaws.com"
                ]
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
resource "aws_iam_instance_profile" "main" {
  provider = aws.primary
  name     = aws_iam_role.main.name
  role     = aws_iam_role.main.id
}

resource "aws_iam_policy" "main" {
  provider    = aws.primary
  name        = "${aws_iam_role.main.name}-policy"
  description = "Allows EC2 instances to call AWS services on your behalf."
  policy      = data.aws_iam_policy_document.s3-bucket-provisioning-instance-profile.json
}

resource "aws_iam_role_policy_attachment" "main" {
  provider   = aws.primary
  role       = aws_iam_role.main.id
  policy_arn = aws_iam_policy.main.arn
}


##creating policy for storage ec2 roles to be allowed to assume s3ObjectManager role
resource "aws_iam_policy" "s3objectmanager" {
  provider    = aws.primary
  name        = var.s3objectmanager_policy_name
  description = "Allows ec2 to assume s3objectmanager role on storage accounts"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = templatefile("${path.module}/policy.json.tftpl", {
    storage_accounts = tolist(var.ambra_storage_accounts)
  })
}
###attach above policy to ec2 role
resource "aws_iam_role_policy_attachment" "s3objectmanager" {
  provider   = aws.primary
  role       = var.instance_role
  policy_arn = aws_iam_policy.s3objectmanager.arn
}
