<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_maintenance_window_task.ssm-powershell-task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_max_concurrency"></a> [max\_concurrency](#input\_max\_concurrency) | n/a | `string` | `"null"` | no |
| <a name="input_max_errors"></a> [max\_errors](#input\_max\_errors) | n/a | `string` | `"null"` | no |
| <a name="input_powershell_task"></a> [powershell\_task](#input\_powershell\_task) | n/a | `number` | `600` | no |
| <a name="input_powershell_task_name"></a> [powershell\_task\_name](#input\_powershell\_task\_name) | n/a | `string` | `"null"` | no |
| <a name="input_powershell_task_priority"></a> [powershell\_task\_priority](#input\_powershell\_task\_priority) | n/a | `string` | `"null"` | no |
| <a name="input_powershell_task_window_id"></a> [powershell\_task\_window\_id](#input\_powershell\_task\_window\_id) | n/a | `string` | `"null"` | no |
| <a name="input_powershell_task_window_target_id"></a> [powershell\_task\_window\_target\_id](#input\_powershell\_task\_window\_target\_id) | n/a | `string` | `"null"` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | n/a | `string` | `"null"` | no |
| <a name="input_timeout_seconds"></a> [timeout\_seconds](#input\_timeout\_seconds) | n/a | `string` | `"null"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->