## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.49.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_customer_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_ec2_tag.tgwa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_vpn_connection.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#input\_cloudwatch\_log\_groups) | n/a | `map` | `{}` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_customer_gateways"></a> [customer\_gateways](#input\_customer\_gateways) | n/a | `map` | `{}` | no |
| <a name="input_default_dh_group_numbers"></a> [default\_dh\_group\_numbers](#input\_default\_dh\_group\_numbers) | n/a | `list` | <pre>[<br>  "14",<br>  "15",<br>  "16",<br>  "17",<br>  "18",<br>  "19",<br>  "20",<br>  "21",<br>  "22",<br>  "23",<br>  "24"<br>]</pre> | no |
| <a name="input_default_encryption_algorithms"></a> [default\_encryption\_algorithms](#input\_default\_encryption\_algorithms) | n/a | `list` | <pre>[<br>  "AES256",<br>  "AES256-GCM-16"<br>]</pre> | no |
| <a name="input_default_integrity_algorithms"></a> [default\_integrity\_algorithms](#input\_default\_integrity\_algorithms) | n/a | `list` | <pre>[<br>  "SHA2-256",<br>  "SHA2-384",<br>  "SHA2-512"<br>]</pre> | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_vpns"></a> [vpns](#input\_vpns) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | n/a |
