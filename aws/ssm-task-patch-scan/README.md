<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_maintenance_window_task.task_patch_scan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_patch_scan_priority"></a> [patch\_scan\_priority](#input\_patch\_scan\_priority) | Priority of job to run. Lower number means higher priority | `number` | n/a | yes |
| <a name="input_cutoff_behavior"></a> [cutoff\_behavior](#input\_cutoff\_behavior) | What to do when end of maintenance window is hit (CONTINUE\_TASK or CANCEL\_TASK) | `string` | `"CANCEL_TASK"` | no |
| <a name="input_max_concurrency"></a> [max\_concurrency](#input\_max\_concurrency) | Max target concurrency run rate | `number` | `"10"` | no |
| <a name="input_max_errors"></a> [max\_errors](#input\_max\_errors) | Max Errors before halting task run | `number` | `"2"` | no |
| <a name="input_notification_arn"></a> [notification\_arn](#input\_notification\_arn) | ARN of SNS notification subscription | `string` | `"arn:aws:sns:us-east-2:601722232065:sre-inf-aws-slack"` | no |
| <a name="input_notification_events"></a> [notification\_events](#input\_notification\_events) | n/a | `list(any)` | <pre>[<br>  "TimedOut",<br>  "Cancelled",<br>  "Failed"<br>]</pre> | no |
| <a name="input_output_s3_bucket"></a> [output\_s3\_bucket](#input\_output\_s3\_bucket) | S3 bucket to deposit run job logs in | `string` | `null` | no |
| <a name="input_output_s3_prefix_key"></a> [output\_s3\_prefix\_key](#input\_output\_s3\_prefix\_key) | S3 bucket to deposit run job logs in | `string` | `null` | no |
| <a name="input_patch_scan_name"></a> [patch\_scan\_name](#input\_patch\_scan\_name) | n/a | `string` | `null` | no |
| <a name="input_patch_scan_window_id"></a> [patch\_scan\_window\_id](#input\_patch\_scan\_window\_id) | Maintenance window ID to associate task with | `string` | `null` | no |
| <a name="input_patch_scan_window_target_id"></a> [patch\_scan\_window\_target\_id](#input\_patch\_scan\_window\_target\_id) | Maintenance window ID to associate task with | `string` | `null` | no |
| <a name="input_s3_region"></a> [s3\_region](#input\_s3\_region) | S3 region log bucket lives | `string` | `null` | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | IAM Role to run step with | `string` | `"arn:aws:iam::959946720450:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM"` | no |
| <a name="input_task_type"></a> [task\_type](#input\_task\_type) | Task Type to run (RUN\_COMMAND or AUTOMATION) | `string` | `"RUN_COMMAND"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->