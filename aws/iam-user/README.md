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
| [aws_iam_access_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_policy.aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email"></a> [email](#input\_email) | n/a | `any` | n/a | yes |
| <a name="input_first_name"></a> [first\_name](#input\_first\_name) | n/a | `any` | n/a | yes |
| <a name="input_last_name"></a> [last\_name](#input\_last\_name) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_user_type"></a> [user\_type](#input\_user\_type) | n/a | `any` | n/a | yes |
| <a name="input_aws_policies"></a> [aws\_policies](#input\_aws\_policies) | n/a | `list` | `[]` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_create_access_key"></a> [create\_access\_key](#input\_create\_access\_key) | n/a | `bool` | `false` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | n/a | `list` | `[]` | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | n/a | `any` | `null` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_path"></a> [path](#input\_path) | n/a | `any` | `null` | no |
| <a name="input_pgp_public_key"></a> [pgp\_public\_key](#input\_pgp\_public\_key) | n/a | `any` | `null` | no |
| <a name="input_product"></a> [product](#input\_product) | n/a | `string` | `"iam"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | n/a | `bool` | `false` | no |
| <a name="input_service_account_map"></a> [service\_account\_map](#input\_service\_account\_map) | n/a | `map(any)` | <pre>{<br>  "false": true,<br>  "true": false<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | n/a |
| <a name="output_access_key_secret"></a> [access\_key\_secret](#output\_access\_key\_secret) | n/a |
<!-- END_TF_DOCS -->