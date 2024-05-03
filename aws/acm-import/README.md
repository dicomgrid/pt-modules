<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 4.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [vault_kv_secret_v2.cert](https://registry.terraform.io/providers/hashicorp/vault/4.2.0/docs/data-sources/kv_secret_v2) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_chain_key"></a> [cert\_chain\_key](#input\_cert\_chain\_key) | Key name for the cert chain in vault path | `string` | `""` | no |
| <a name="input_cert_key"></a> [cert\_key](#input\_cert\_key) | Key name for the cert in vault path | `string` | `""` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_mount"></a> [mount](#input\_mount) | Vault mount | `string` | `"secret"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Vault Namespace | `string` | `""` | no |
| <a name="input_private-key_key"></a> [private-key\_key](#input\_private-key\_key) | Key name for the cert key in vault path | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |
| <a name="input_vault_secret_name"></a> [vault\_secret\_name](#input\_vault\_secret\_name) | Vault Namespace | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_arn"></a> [acm\_arn](#output\_acm\_arn) | n/a |
| <a name="output_acm_domain"></a> [acm\_domain](#output\_acm\_domain) | n/a |
<!-- END_TF_DOCS -->