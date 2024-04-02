data "vault_kv_secret_v2" "cert" {
  namespace = var.namespace
  mount     = var.mount
  name      = var.vault_secret_name
}



