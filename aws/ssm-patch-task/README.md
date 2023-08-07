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
| [aws_ssm_maintenance_window_task.ssm-patch-task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_max_concurrency"></a> [max\_concurrency](#input\_max\_concurrency) | n/a | `string` | `"null"` | no |
| <a name="input_max_errors"></a> [max\_errors](#input\_max\_errors) | n/a | `string` | `"null"` | no |
| <a name="input_patch_task_name"></a> [patch\_task\_name](#input\_patch\_task\_name) | n/a | `string` | `"null"` | no |
| <a name="input_patch_task_priority"></a> [patch\_task\_priority](#input\_patch\_task\_priority) | n/a | `string` | `"null"` | no |
| <a name="input_patch_tasks"></a> [patch\_tasks](#input\_patch\_tasks) | n/a | <pre>list(object({<br>    name = string<br>    values = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "name": "Operation",<br>    "values": [<br>      "Scan"<br>    ]<br>  },<br>  {<br>    "name": "RebootOption",<br>    "values": [<br>      "NoReboot"<br>    ]<br>  },<br>  {<br>    "name": "PreInstallHookDocName",<br>    "values": [<br>      "AWS-Noop"<br>    ]<br>  },<br>  {<br>    "name": "PostInstallHookDocName",<br>    "values": [<br>      "AWS-Noop"<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_patch_window_id"></a> [patch\_window\_id](#input\_patch\_window\_id) | n/a | `string` | `"null"` | no |
| <a name="input_patch_window_target_id"></a> [patch\_window\_target\_id](#input\_patch\_window\_target\_id) | n/a | `string` | `"null"` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | n/a | `string` | `"null"` | no |
| <a name="input_timeout_seconds"></a> [timeout\_seconds](#input\_timeout\_seconds) | n/a | `number` | `600` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->