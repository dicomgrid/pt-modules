<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_principal_association"></a> [principal\_association](#module\_principal\_association) | ../principal-association | n/a |
| <a name="module_resource_association"></a> [resource\_association](#module\_resource\_association) | ../resource-association | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ram_resource_share.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_external_principals"></a> [allow\_external\_principals](#input\_allow\_external\_principals) | n/a | `bool` | `false` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_permission_arns"></a> [permission\_arns](#input\_permission\_arns) | n/a | `any` | `null` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | n/a | `list` | `[]` | no |
| <a name="input_resource_arns"></a> [resource\_arns](#input\_resource\_arns) | n/a | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allow_external_principals"></a> [allow\_external\_principals](#output\_allow\_external\_principals) | n/a |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_permission_arns"></a> [permission\_arns](#output\_permission\_arns) | n/a |
| <a name="output_principal_associations"></a> [principal\_associations](#output\_principal\_associations) | n/a |
| <a name="output_resource_associations"></a> [resource\_associations](#output\_resource\_associations) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | n/a |
<!-- END_TF_DOCS -->