<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_value"></a> [value](#input\_value) | n/a | `any` | n/a | yes |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_data_type"></a> [data\_type](#input\_data\_type) | n/a | `string` | `"text"` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `any` | `null` | no |
| <a name="input_kms_id"></a> [kms\_id](#input\_kms\_id) | n/a | `any` | `null` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_overwrite"></a> [overwrite](#input\_overwrite) | n/a | `bool` | `false` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | n/a | `string` | `"Standard"` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | `"String"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | n/a |
| <a name="output_version"></a> [version](#output\_version) | n/a |
<!-- END_TF_DOCS -->