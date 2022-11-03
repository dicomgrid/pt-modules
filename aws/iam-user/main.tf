resource "aws_iam_user" "main" {
  name = var.name
  path = var.path
  force_destroy = var.service_account
  tags = {
    Compliance  = lookup(var.tags, "compliance", "NONE")
    Email       = var.email
    Environment = lookup(var.tags, "environment", "Master")
    Name        = "iam_user:${var.name}"
    Owner       = lookup(var.tags, "owner", "Platform")
    Product     = lookup(var.tags, "product", "Platform Infrastructure")
    User_Name   = "${var.first_name} ${var.last_name}"
    User_Type   = var.user_type
  }
}

resource "aws_iam_user_group_membership" "main" {
  user     = aws_iam_user.main.name
  groups   = var.groups
}