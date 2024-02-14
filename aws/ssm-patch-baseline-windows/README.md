## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_patch_baseline.windows_pb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_baseline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approval_day_count"></a> [approval\_day\_count](#input\_approval\_day\_count) | n/a | `number` | `7` | no |
| <a name="input_approved_patches"></a> [approved\_patches](#input\_approved\_patches) | n/a | `list` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_rejected_patches"></a> [rejected\_patches](#input\_rejected\_patches) | n/a | `list` | `[]` | no |
| <a name="input_windows_patch_classification"></a> [windows\_patch\_classification](#input\_windows\_patch\_classification) | n/a | `list(string)` | <pre>[<br>  "CriticalUpdates",<br>  "DefinitionUpdates",<br>  "Drivers",<br>  "FeaturePacks",<br>  "SecurityUpdates",<br>  "ServicePacks",<br>  "Tools",<br>  "UpdateRollups",<br>  "Updates",<br>  "Upgrades"<br>]</pre> | no |
| <a name="input_windows_patch_product"></a> [windows\_patch\_product](#input\_windows\_patch\_product) | n/a | `list(string)` | <pre>[<br>  "WindowsServer2012R2",<br>  "WindowsServer2016",<br>  "WindowsServer2019",<br>  "WindowsServer2022",<br>  "MicrosoftDefenderAntivirus"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_patch_baseline.windows_pb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_baseline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approval_day_count"></a> [approval\_day\_count](#input\_approval\_day\_count) | n/a | `number` | `7` | no |
| <a name="input_approve_until_date"></a> [approve\_until\_date](#input\_approve\_until\_date) | n/a | `any` | `null` | no |
| <a name="input_approved_patches"></a> [approved\_patches](#input\_approved\_patches) | n/a | `list` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_rejected_patches"></a> [rejected\_patches](#input\_rejected\_patches) | n/a | `list` | `[]` | no |
| <a name="input_windows_patch_classification"></a> [windows\_patch\_classification](#input\_windows\_patch\_classification) | n/a | `list(string)` | <pre>[<br>  "CriticalUpdates",<br>  "DefinitionUpdates",<br>  "Drivers",<br>  "FeaturePacks",<br>  "SecurityUpdates",<br>  "ServicePacks",<br>  "Tools",<br>  "UpdateRollups",<br>  "Updates",<br>  "Upgrades"<br>]</pre> | no |
| <a name="input_windows_patch_product"></a> [windows\_patch\_product](#input\_windows\_patch\_product) | n/a | `list(string)` | <pre>[<br>  "WindowsServer2012R2",<br>  "WindowsServer2016",<br>  "WindowsServer2019",<br>  "WindowsServer2022",<br>  "MicrosoftDefenderAntivirus"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->