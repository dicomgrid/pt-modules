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
| <a name="module_attachment_route_table"></a> [attachment\_route\_table](#module\_attachment\_route\_table) | ../attachment-route-table | n/a |
| <a name="module_connect_attachments"></a> [connect\_attachments](#module\_connect\_attachments) | ../connect-attachment | n/a |
| <a name="module_tgw_routes"></a> [tgw\_routes](#module\_tgw\_routes) | ../routes | n/a |
| <a name="module_vpc_routes"></a> [vpc\_routes](#module\_vpc\_routes) | ../vpc-routes | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_vpc_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_route_table_id"></a> [association\_route\_table\_id](#input\_association\_route\_table\_id) | n/a | `any` | `null` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_connect_attachments"></a> [connect\_attachments](#input\_connect\_attachments) | n/a | `map` | `{}` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_propagation_route_table_ids"></a> [propagation\_route\_table\_ids](#input\_propagation\_route\_table\_ids) | n/a | `list` | `[]` | no |
| <a name="input_subnets_tags_filter"></a> [subnets\_tags\_filter](#input\_subnets\_tags\_filter) | Addtional filter option for subnets to use with VPC attachment | `string` | `"*"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | n/a | `any` | n/a | yes |
| <a name="input_tgw_routes"></a> [tgw\_routes](#input\_tgw\_routes) | n/a | `list` | `[]` | no |
| <a name="input_transit_gateway_default_route_table_association"></a> [transit\_gateway\_default\_route\_table\_association](#input\_transit\_gateway\_default\_route\_table\_association) | n/a | `bool` | `true` | no |
| <a name="input_transit_gateway_default_route_table_propagation"></a> [transit\_gateway\_default\_route\_table\_propagation](#input\_transit\_gateway\_default\_route\_table\_propagation) | n/a | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |
| <a name="input_vpc_routes"></a> [vpc\_routes](#input\_vpc\_routes) | n/a | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connect_attachments"></a> [connect\_attachments](#output\_connect\_attachments) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | n/a |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | n/a |
| <a name="output_vpc_routes"></a> [vpc\_routes](#output\_vpc\_routes) | n/a |
