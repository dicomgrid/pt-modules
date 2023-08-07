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
| <a name="input_name"></a> [name](#input\_name) | Input Variables | `any` | n/a | yes |
| <a name="input_ou_name"></a> [ou\_name](#input\_ou\_name) | n/a | `any` | n/a | yes |
| <a name="input_accounts"></a> [accounts](#input\_accounts) | Static Variables | `map(any)` | `{}` | no |
| <a name="input_role"></a> [role](#input\_role) | n/a | `string` | `"cross_account_admin"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ou_map"></a> [ou\_map](#output\_ou\_map) | n/a |
<!-- END_TF_DOCS -->