resource "aws_ssoadmin_account_assignment" "assignment" {
  for_each           = local.account_bindings_dict
  instance_arn       = var.sso_instance_arn
  permission_set_arn = var.permsets_map[each.value.permset].arn
  principal_id       = var.groups_map[each.value.group].id
  principal_type     = "GROUP"
  target_type        = "AWS_ACCOUNT"
  target_id          = var.accounts_id_map[var.account_name]
}