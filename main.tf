provider "aws" {
  region = "us-east-2"
}



resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = var.description

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}

resource "aws_secretsmanager_secret_policy" "this" {
  secret_arn = aws_secretsmanager_secret.this.arn

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::637423399955:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_organization-cloud-admin_a31c3fdf3e2997ee"
        },
        "Action": [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        "Resource": "*"
      }
    ]
  })
}