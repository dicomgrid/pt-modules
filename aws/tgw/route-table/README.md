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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_route_table.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_attachments"></a> [association\_attachments](#input\_association\_attachments) | n/a | `set(string)` | `[]` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_create_route_table"></a> [create\_route\_table](#input\_create\_route\_table) | n/a | `bool` | `true` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_propagation_attachments"></a> [propagation\_attachments](#input\_propagation\_attachments) | n/a | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | n/a | `any` | `null` | no |
| <a name="input_transit_gateway_route_table_id"></a> [transit\_gateway\_route\_table\_id](#input\_transit\_gateway\_route\_table\_id) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
