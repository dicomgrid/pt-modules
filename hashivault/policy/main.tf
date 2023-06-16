resource "vault_policy" "admin_policy" {
  name   = var.name
  policy = var.policy
}
