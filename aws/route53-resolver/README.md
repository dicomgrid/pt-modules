<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoint_info"></a> [endpoint\_info](#module\_endpoint\_info) | ../common/vpc-subnet-id-per-az-lookup | n/a |
| <a name="module_resolver"></a> [resolver](#module\_resolver) | ./resolver | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ../security-group | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_direction"></a> [direction](#input\_direction) | n/a | `any` | n/a | yes |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `any` | n/a | yes |
| <a name="input_egress_default"></a> [egress\_default](#input\_egress\_default) | n/a | `list` | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "All traffic",<br>    "from_port": "0",<br>    "protocol": "-1",<br>    "to_port": "0"<br>  }<br>]</pre> | no |
| <a name="input_endpoint_name"></a> [endpoint\_name](#input\_endpoint\_name) | n/a | `string` | `"default-rslvr"` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | n/a | `map` | `{}` | no |
| <a name="input_subnets_filter"></a> [subnets\_filter](#input\_subnets\_filter) | n/a | `string` | `"*"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->