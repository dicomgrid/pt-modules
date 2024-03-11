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
| [aws_ec2_transit_gateway_route_table_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_route_table_id"></a> [association\_route\_table\_id](#input\_association\_route\_table\_id) | n/a | `any` | `null` | no |
| <a name="input_propagation_route_table_ids"></a> [propagation\_route\_table\_ids](#input\_propagation\_route\_table\_ids) | n/a | `list` | `[]` | no |
| <a name="input_transit_gateway_attachment_id"></a> [transit\_gateway\_attachment\_id](#input\_transit\_gateway\_attachment\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_association_id"></a> [association\_id](#output\_association\_id) | n/a |
| <a name="output_propagation_ids"></a> [propagation\_ids](#output\_propagation\_ids) | n/a |
