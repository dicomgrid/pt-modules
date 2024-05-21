## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.66.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.66.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_filestore_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/filestore_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_mode"></a> [access\_mode](#input\_access\_mode) | n/a | `any` | n/a | yes |
| <a name="input_capacity_gb"></a> [capacity\_gb](#input\_capacity\_gb) | n/a | `number` | `100` | no |
| <a name="input_connect_mode"></a> [connect\_mode](#input\_connect\_mode) | n/a | `string` | `"DIRECT_PEERING"` | no |
| <a name="input_include_nfs_export_options"></a> [include\_nfs\_export\_options](#input\_include\_nfs\_export\_options) | n/a | `bool` | `true` | no |
| <a name="input_ip_ranges"></a> [ip\_ranges](#input\_ip\_ranges) | n/a | `list` | `[]` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | n/a | `any` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_modes"></a> [modes](#input\_modes) | n/a | `list` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | n/a | `any` | n/a | yes |
| <a name="input_share_name"></a> [share\_name](#input\_share\_name) | n/a | `any` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | n/a | `string` | `"BASIC_SSD"` | no |

## Outputs

No outputs.
