resource "aws_s3_bucket" "main" {
  bucket = var.bucket
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  tags = {
    Application = var.application
    Billing     = var.billing
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }
}