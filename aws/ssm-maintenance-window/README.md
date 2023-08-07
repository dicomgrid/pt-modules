## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_maintenance_window.maintenance_window](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cutoff"></a> [cutoff](#input\_cutoff) | n/a | `number` | `1` | no |
| <a name="input_duration"></a> [duration](#input\_duration) | n/a | `number` | `2` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | n/a | `string` | `""` | no |
| <a name="input_schedule_timezone"></a> [schedule\_timezone](#input\_schedule\_timezone) | n/a | `string` | `"America/New_York"` | no |
| <a name="input_window_enabled"></a> [window\_enabled](#input\_window\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_window_name"></a> [window\_name](#input\_window\_name) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_maintenance-window-id"></a> [maintenance-window-id](#output\_maintenance-window-id) | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_maintenance_window.maintenance_window](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cutoff"></a> [cutoff](#input\_cutoff) | n/a | `number` | `1` | no |
| <a name="input_duration"></a> [duration](#input\_duration) | n/a | `number` | `2` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | n/a | `string` | `""` | no |
| <a name="input_schedule_timezone"></a> [schedule\_timezone](#input\_schedule\_timezone) | n/a | `string` | `"America/New_York"` | no |
| <a name="input_window_enabled"></a> [window\_enabled](#input\_window\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_window_name"></a> [window\_name](#input\_window\_name) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_maintenance-window-id"></a> [maintenance-window-id](#output\_maintenance-window-id) | n/a |
<!-- END_TF_DOCS -->