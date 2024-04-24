## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0, < 2.0.0 |
| <a name="requirement_panos"></a> [panos](#requirement\_panos) | ~> 1.11.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_panos"></a> [panos](#provider\_panos) | ~> 1.11.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [panos_gre_tunnel.main](https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs/resources/gre_tunnel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_copy_tos"></a> [copy\_tos](#input\_copy\_tos) | n/a | `any` | `null` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | n/a | `any` | `null` | no |
| <a name="input_enable_keep_alive"></a> [enable\_keep\_alive](#input\_enable\_keep\_alive) | n/a | `any` | `null` | no |
| <a name="input_interface"></a> [interface](#input\_interface) | n/a | `any` | n/a | yes |
| <a name="input_keep_alive_hold_timer"></a> [keep\_alive\_hold\_timer](#input\_keep\_alive\_hold\_timer) | n/a | `any` | `null` | no |
| <a name="input_keep_alive_interval"></a> [keep\_alive\_interval](#input\_keep\_alive\_interval) | n/a | `any` | `null` | no |
| <a name="input_keep_alive_retry"></a> [keep\_alive\_retry](#input\_keep\_alive\_retry) | n/a | `any` | `null` | no |
| <a name="input_local_address"></a> [local\_address](#input\_local\_address) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_peer_address"></a> [peer\_address](#input\_peer\_address) | n/a | `any` | n/a | yes |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | n/a | `any` | `null` | no |
| <a name="input_tunnel_interface"></a> [tunnel\_interface](#input\_tunnel\_interface) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
