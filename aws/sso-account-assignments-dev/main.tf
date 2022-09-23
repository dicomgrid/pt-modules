data "aws_ssoadmin_instances" "instance" {}

data "aws_ssoadmin_permission_set" "permset" {
  instance_arn = tolist(data.aws_ssoadmin_instances.instance.arns)[0]
  name         = var.permset_name
}

data "aws_identitystore_group" "group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instance.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = var.group
  }
}

resource "aws_ssoadmin_account_assignment" "assignment" {
  for_each = var.account_list
  instance_arn       = data.aws_ssoadmin_permission_set.permset.instance_arn
  permission_set_arn = data.aws_ssoadmin_permission_set.permset.arn
  principal_id = data.aws_identitystore_group.group.group_id
  principal_type = "GROUP"
  target_type = "AWS_ACCOUNT"
  target_id   = each.key
}

