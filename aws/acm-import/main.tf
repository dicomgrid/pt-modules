resource "aws_acm_certificate" "main" {
  private_key       = base64decode(data.vault_kv_secret_v2.cert.data["${var.private-key_key}"])
  certificate_body  = base64decode(data.vault_kv_secret_v2.cert.data["${var.cert_key}"])
  certificate_chain = base64decode(data.vault_kv_secret_v2.cert.data["${var.cert_chain_key}"])


  tags = local.tags
}
