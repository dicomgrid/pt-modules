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
| [aws_ssm_maintenance_window_target.maintenance_window_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of maintenance window target | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Resource Group that contains maintenance window targets | `string` | `""` | no |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | Type of target. Example: RESOURCE\_GROUP | `string` | `""` | no |
| <a name="input_window_id"></a> [window\_id](#input\_window\_id) | Maintenance Window ID to associate to targets | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_maintenance-window-target"></a> [maintenance-window-target](#output\_maintenance-window-target) | n/a |
<!-- END_TF_DOCS -->