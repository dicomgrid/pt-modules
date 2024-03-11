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

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_connect.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_connect) | resource |
| [aws_ec2_transit_gateway_connect_peer.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_connect_peer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_route_table_id"></a> [association\_route\_table\_id](#input\_association\_route\_table\_id) | n/a | `any` | `null` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | `null` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_peers"></a> [peers](#input\_peers) | n/a | `map` | `{}` | no |
| <a name="input_propagation_route_table_ids"></a> [propagation\_route\_table\_ids](#input\_propagation\_route\_table\_ids) | n/a | `list` | `[]` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | n/a | `string` | `"gre"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_transit_gateway_default_route_table_association"></a> [transit\_gateway\_default\_route\_table\_association](#input\_transit\_gateway\_default\_route\_table\_association) | n/a | `bool` | `true` | no |
| <a name="input_transit_gateway_default_route_table_propagation"></a> [transit\_gateway\_default\_route\_table\_propagation](#input\_transit\_gateway\_default\_route\_table\_propagation) | n/a | `bool` | `true` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | n/a | `any` | `null` | no |
| <a name="input_transport_attachment_id"></a> [transport\_attachment\_id](#input\_transport\_attachment\_id) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_attachment_route_tables"></a> [attachment\_route\_tables](#output\_attachment\_route\_tables) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_peer"></a> [peer](#output\_peer) | n/a |
| <a name="output_transport_attachment_id"></a> [transport\_attachment\_id](#output\_transport\_attachment\_id) | n/a |
