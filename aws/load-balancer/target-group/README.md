## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attachments"></a> [attachments](#input\_attachments) | n/a | `list` | <pre>[<br>  {}<br>]</pre> | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_connection_termination"></a> [connection\_termination](#input\_connection\_termination) | n/a | `any` | `null` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | n/a | `any` | `null` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | `map` | `{}` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | n/a | `any` | `null` | no |
| <a name="input_lambda_multi_value_headers_enabled"></a> [lambda\_multi\_value\_headers\_enabled](#input\_lambda\_multi\_value\_headers\_enabled) | n/a | `any` | `null` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | n/a | `any` | `null` | no |
| <a name="input_load_balancing_algorithm_type"></a> [load\_balancing\_algorithm\_type](#input\_load\_balancing\_algorithm\_type) | n/a | `any` | `null` | no |
| <a name="input_load_balancing_cross_zone_enabled"></a> [load\_balancing\_cross\_zone\_enabled](#input\_load\_balancing\_cross\_zone\_enabled) | n/a | `any` | `null` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `any` | `null` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_port"></a> [port](#input\_port) | n/a | `any` | n/a | yes |
| <a name="input_preserve_client_ip"></a> [preserve\_client\_ip](#input\_preserve\_client\_ip) | n/a | `any` | `null` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_protocol_version"></a> [protocol\_version](#input\_protocol\_version) | n/a | `any` | `null` | no |
| <a name="input_proxy_protocol_v2"></a> [proxy\_protocol\_v2](#input\_proxy\_protocol\_v2) | n/a | `any` | `null` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | n/a | `any` | `null` | no |
| <a name="input_stickiness"></a> [stickiness](#input\_stickiness) | n/a | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_target_failover"></a> [target\_failover](#input\_target\_failover) | n/a | `map` | `{}` | no |
| <a name="input_target_health_state"></a> [target\_health\_state](#input\_target\_health\_state) | n/a | `map` | `{}` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | n/a | `string` | `"instance"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
