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
| [vault_kv_secret_backend_v2.kvv2_backend](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/kv_secret_backend_v2) | resource |
| [vault_mount.kvv1](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/mount) | resource |
| [vault_mount.kvv2](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/mount) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_managed_keys"></a> [allowed\_managed\_keys](#input\_allowed\_managed\_keys) | n/a | `list` | `[]` | no |
| <a name="input_cas_required"></a> [cas\_required](#input\_cas\_required) | n/a | `bool` | `true` | no |
| <a name="input_delete_version_after"></a> [delete\_version\_after](#input\_delete\_version\_after) | n/a | `number` | `12600` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `""` | no |
| <a name="input_max_versions"></a> [max\_versions](#input\_max\_versions) | n/a | `number` | `5` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `any` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | n/a | `string` | `"secret/"` | no |

## Outputs

No outputs.
