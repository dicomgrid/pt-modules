<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organization.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organizational_units.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing"></a> [billing](#input\_billing) | # Tags ## | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_ou_name"></a> [ou\_name](#input\_ou\_name) | n/a | `any` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `any` | n/a | yes |
| <a name="input_base_email"></a> [base\_email](#input\_base\_email) | n/a | `string` | `"aws@intelerad.com"` | no |
| <a name="input_close_on_deletion"></a> [close\_on\_deletion](#input\_close\_on\_deletion) | n/a | `bool` | `false` | no |
| <a name="input_email"></a> [email](#input\_email) | n/a | `any` | `null` | no |
| <a name="input_role"></a> [role](#input\_role) | n/a | `string` | `"cross_account_admin"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_close_on_deletion"></a> [close\_on\_deletion](#output\_close\_on\_deletion) | n/a |
| <a name="output_email"></a> [email](#output\_email) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_ou_map"></a> [ou\_map](#output\_ou\_map) | n/a |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | n/a |
<!-- END_TF_DOCS -->