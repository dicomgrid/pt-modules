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
| [vault_mount.ssh](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/mount) | resource |
| [vault_ssh_secret_backend_ca.ssh_backend](https://registry.terraform.io/providers/hashicorp/vault/3.15.2/docs/resources/ssh_secret_backend_ca) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_generate_signing_key"></a> [generate\_signing\_key](#input\_generate\_signing\_key) | n/a | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `any` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | n/a | `string` | `"ssh-client-signer"` | no |

## Outputs

No outputs.
