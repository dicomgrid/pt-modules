locals {
  key_arn = data.aws_kms_key.by_alias.arn
}
variable "enabled" { default = true }
variable "key_alias" { default = "alias/default-ebs-key" }