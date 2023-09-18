resource "vault_policy" "admin_policy" {
  name      = var.name
  namespace = var.namespace
  policy    = var.policy
}
