resource "vault_policy" "main" {
  name      = var.name
  namespace = var.namespace
  policy    = var.policy
}
