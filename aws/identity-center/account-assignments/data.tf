data "aws_organizations_organization" "main" {}
data "aws_ssoadmin_instances" "instance" {}

data "aws_identitystore_group" "group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.instance.identity_store_ids)[0]

  for_each = local.account_bindings_dict
  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.value.group
    }
  }
}

data "aws_ssoadmin_permission_set" "permset" {
  instance_arn = tolist(data.aws_ssoadmin_instances.instance.arns)[0]

  for_each = local.account_bindings_dict
  name     = each.value.permset
}