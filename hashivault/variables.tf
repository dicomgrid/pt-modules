variable "vault_address" {
  default = "https://ims-vault-private-vault-0c0b9478.378a5bfe.z1.hashicorp.cloud:8200/"
}

variable "vault_namespace" {
  default = "admin"
}

variable "approle_name" {
  default = "plat"
}

data "aws_ssm_parameter" "plat-role-id" {
  name            = "/uat/sensitive/hashivault/plat-role-id"
  with_decryption = true
}

data "aws_ssm_parameter" "plat-secret-id" {
  name            = "/uat/sensitive/hashivault/plat-secret-id"
  with_decryption = true
}

