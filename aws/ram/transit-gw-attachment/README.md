### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.64.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnet_routes"></a> [subnet\_routes](#module\_subnet\_routes) | ../subnet-routes | n/a |

### Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_vpc_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment_accepter.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment_accepter) | resource |
| [aws_route_tables.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | The tgw id of the tgw that is to be shared | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the subnets are located | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to be applied to all resources | `map(string)` | `{}` | no |
| <a name="input_destination_cidr_blocks"></a> [destination\_cidr\_blocks](#input\_destination\_cidr\_blocks) | n/a | `list` | `[]` | no |
| <a name="input_subnets_filter"></a> [subnets\_filter](#input\_subnets\_filter) | n/a | `string` | `"*"` | no |

### Outputs

No outputs.
