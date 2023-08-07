<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_maintenance_window_task.ssm-shell-task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_max_concurrency"></a> [max\_concurrency](#input\_max\_concurrency) | n/a | `string` | `"null"` | no |
| <a name="input_max_errors"></a> [max\_errors](#input\_max\_errors) | n/a | `string` | `"null"` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | n/a | `string` | `"null"` | no |
| <a name="input_shell_task"></a> [shell\_task](#input\_shell\_task) | n/a | `number` | `600` | no |
| <a name="input_shell_task_name"></a> [shell\_task\_name](#input\_shell\_task\_name) | n/a | `string` | `"null"` | no |
| <a name="input_shell_task_priority"></a> [shell\_task\_priority](#input\_shell\_task\_priority) | n/a | `string` | `"null"` | no |
| <a name="input_shell_task_window_id"></a> [shell\_task\_window\_id](#input\_shell\_task\_window\_id) | n/a | `string` | `"null"` | no |
| <a name="input_shell_task_window_target_id"></a> [shell\_task\_window\_target\_id](#input\_shell\_task\_window\_target\_id) | n/a | `string` | `"null"` | no |
| <a name="input_timeout_seconds"></a> [timeout\_seconds](#input\_timeout\_seconds) | n/a | `string` | `"null"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->