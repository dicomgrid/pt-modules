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
| [vault_auth_backend.main](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/auth_backend) | resource |
| [vault_kubernetes_auth_backend_config.main](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/kubernetes_auth_backend_config) | resource |
| [vault_kubernetes_auth_backend_role.main](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/kubernetes_auth_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audience"></a> [audience](#input\_audience) | n/a | `string` | `"vault"` | no |
| <a name="input_bound_service_account_names"></a> [bound\_service\_account\_names](#input\_bound\_service\_account\_names) | n/a | `list` | `[]` | no |
| <a name="input_bound_service_account_namespaces"></a> [bound\_service\_account\_namespaces](#input\_bound\_service\_account\_namespaces) | n/a | `list` | `[]` | no |
| <a name="input_disable_iss_validation"></a> [disable\_iss\_validation](#input\_disable\_iss\_validation) | n/a | `bool` | `true` | no |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | n/a | `string` | `"api"` | no |
| <a name="input_kubernetes_ca_cert"></a> [kubernetes\_ca\_cert](#input\_kubernetes\_ca\_cert) | n/a | `string` | `""` | no |
| <a name="input_kubernetes_host"></a> [kubernetes\_host](#input\_kubernetes\_host) | n/a | `string` | `""` | no |
| <a name="input_token_policies"></a> [token\_policies](#input\_token\_policies) | n/a | `list` | `[]` | no |
| <a name="input_token_reviewer_jwt"></a> [token\_reviewer\_jwt](#input\_token\_reviewer\_jwt) | n/a | `string` | `""` | no |
| <a name="input_token_ttl"></a> [token\_ttl](#input\_token\_ttl) | n/a | `number` | `3600` | no |

## Outputs

No outputs.
