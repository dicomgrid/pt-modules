<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

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
| <a name="input_description"></a> [description](#input\_description) | Description of patch baseline | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | name of patch baseline | `string` | `""` | no |
| <a name="input_windows_approved_patches"></a> [windows\_approved\_patches](#input\_windows\_approved\_patches) | n/a | `list(string)` | <pre>[<br>  "KB123456"<br>]</pre> | no |
| <a name="input_windows_patch_classification"></a> [windows\_patch\_classification](#input\_windows\_patch\_classification) | n/a | `list(string)` | <pre>[<br>  "CriticalUpdates",<br>  "DefinitionUpdates",<br>  "Drivers",<br>  "FeaturePacks",<br>  "SecurityUpdates",<br>  "ServicePacks",<br>  "Tools",<br>  "UpdateRollups",<br>  "Updates",<br>  "Upgrades"<br>]</pre> | no |
| <a name="input_windows_patch_product"></a> [windows\_patch\_product](#input\_windows\_patch\_product) | n/a | `list(string)` | <pre>[<br>  "WindowsServer2012R2",<br>  "WindowsServer2016",<br>  "WindowsServer2019",<br>  "WindowsServer2022",<br>  "MicrosoftDefenderAntivirus"<br>]</pre> | no |
| <a name="input_windows_rejected_patches"></a> [windows\_rejected\_patches](#input\_windows\_rejected\_patches) | n/a | `list(string)` | <pre>[<br>  "KB123456"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_windows-pb-arn"></a> [windows-pb-arn](#output\_windows-pb-arn) | n/a |
| <a name="output_windows-pb-id"></a> [windows-pb-id](#output\_windows-pb-id) | n/a |
<!-- END_TF_DOCS -->