## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.accepter"></a> [aws.accepter](#provider\_aws.accepter) | ~> 4.64.0 |
| <a name="provider_aws.requester"></a> [aws.requester](#provider\_aws.requester) | ~> 4.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnet_routes"></a> [subnet\_routes](#module\_subnet\_routes) | ./subnet-routes | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_vpc_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment_accepter.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment_accepter) | resource |
| [aws_route_tables.routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_destination_cidr_blocks"></a> [destination\_cidr\_blocks](#input\_destination\_cidr\_blocks) | n/a | `list` | `[]` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_routes_subnet_name_values"></a> [routes\_subnet\_name\_values](#input\_routes\_subnet\_name\_values) | List of tag:Name values to filter subnets' route tables the routes should be added to. Default [] is all subnets for VPC | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | The tgw id of the tgw that is to be shared | `any` | n/a | yes |
| <a name="input_tgwa_subnet_name_values"></a> [tgwa\_subnet\_name\_values](#input\_tgwa\_subnet\_name\_values) | List of tag:Name values to filter subnets the TGW should be attached to. Default [] is any subnets for VPC | `set(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the subnets are located | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accepter"></a> [accepter](#output\_accepter) | n/a |
| <a name="output_requester"></a> [requester](#output\_requester) | n/a |
