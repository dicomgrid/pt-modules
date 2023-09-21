## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 3.15.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.15.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_mount.main](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/mount) | resource |
| [vault_pki_secret_backend_role.main](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/pki_secret_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ip_sans"></a> [allow\_ip\_sans](#input\_allow\_ip\_sans) | n/a | `bool` | `true` | no |
| <a name="input_allow_subdomains"></a> [allow\_subdomains](#input\_allow\_subdomains) | n/a | `bool` | `true` | no |
| <a name="input_allowed_domains"></a> [allowed\_domains](#input\_allowed\_domains) | n/a | `list` | `[]` | no |
| <a name="input_default_lease_ttl_seconds"></a> [default\_lease\_ttl\_seconds](#input\_default\_lease\_ttl\_seconds) | n/a | `number` | `3600` | no |
| <a name="input_key_bits"></a> [key\_bits](#input\_key\_bits) | n/a | `number` | `4096` | no |
| <a name="input_key_type"></a> [key\_type](#input\_key\_type) | n/a | `string` | `"rsa"` | no |
| <a name="input_max_lease_ttl_seconds"></a> [max\_lease\_ttl\_seconds](#input\_max\_lease\_ttl\_seconds) | n/a | `number` | `86400` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | n/a | `number` | `3600` | no |

## Outputs

No outputs.
