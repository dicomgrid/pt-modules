<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Environment"></a> [Environment](#input\_Environment) | n/a | `any` | n/a | yes |
| <a name="input_Name"></a> [Name](#input\_Name) | n/a | `any` | n/a | yes |
| <a name="input_instance_id"></a> [instance\_id](#input\_instance\_id) | n/a | `any` | n/a | yes |
| <a name="input_Application"></a> [Application](#input\_Application) | n/a | `string` | `"default"` | no |
| <a name="input_Billing"></a> [Billing](#input\_Billing) | n/a | `string` | `""` | no |
| <a name="input_Creator"></a> [Creator](#input\_Creator) | n/a | `string` | `"terraform"` | no |
| <a name="input_Owner"></a> [Owner](#input\_Owner) | n/a | `string` | `"platform"` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `any` | `null` | no |
| <a name="input_byoip_pool"></a> [byoip\_pool](#input\_byoip\_pool) | n/a | `bool` | `false` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"vpc"` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `any` | `null` | no |
| <a name="input_network_border_group"></a> [network\_border\_group](#input\_network\_border\_group) | Added by Pavel to accomodate Houston LZ EIP allocation | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
<!-- END_TF_DOCS -->