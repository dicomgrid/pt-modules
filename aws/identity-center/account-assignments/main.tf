resource "aws_ssoadmin_account_assignment" "assignment" {
  for_each           = local.account_bindings_dict
  instance_arn       = local.permset_data[each.key].instance_arn
  permission_set_arn = local.permset_data[each.key].arn
  principal_id       = local.group_data[each.key].id
  principal_type     = "GROUP"
  target_type        = "AWS_ACCOUNT"
  target_id          = local.accounts_id_map[var.account_name]
}