module "group" {
  source = "../identity-group"

  for_each = var.groups

  group_aliases = { for k, v in each.value.group_aliases : k => merge({ mount_accessor = module.jwt_auth["${v.mount_path}"].accessor }, v) }
  name          = each.key
  namespace     = try(each.value.namespace, var.namespace)
  policies      = [for policy in each.value.policies : try(module.policy[policy].name, "${policy}")]
  type          = try(each.value.type, "external")
}

module "jwt_auth" {
  source = "../jwt-auth-backend"

  for_each = merge(
    { for k, v in local.auth_methods.jwt : k => merge({ "path" = "${k}", "type" = "jwt" }, v) },
    { for k, v in local.auth_methods.oidc : k => merge({ "path" = "${k}", "type" = "oidc" }, v) }
  )

  default_role       = try(each.value.default_role, null)
  namespace          = try(each.value.namespace, var.namespace)
  oidc_client_id     = try(each.value.oidc_client_id, null)
  oidc_client_secret = try(each.value.oidc_client_secret, null)
  oidc_discovery_url = each.value.oidc_discovery_url
  path               = each.value.path
  roles              = try(each.value.roles, {})
  type               = try(each.value.type, "jwt")
}

module "policy" {
  source = "../policy"

  for_each = var.policies

  name      = each.key
  namespace = try(each.value.namespace, var.namespace)
  policy    = each.value.policy
}
