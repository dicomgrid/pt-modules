data "aws_ssoadmin_instances" "instance" {}

data "aws_ssoadmin_permission_set" "permset" {
  instance_arn = tolist(data.aws_ssoadmin_instances.instance.arns)[0]
  name         = aws_ssoadmin_permission_set.permission_set.name
}

data "aws_identitystore_group" "group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instance.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = var.group
  }
}

data "aws_iam_policy" "customer" {
  for_each = toset(var.policies)
  name = each.value
}

data "aws_iam_policy" "aws" {
  for_each = toset(var.aws_policies)
  name = each.value
}