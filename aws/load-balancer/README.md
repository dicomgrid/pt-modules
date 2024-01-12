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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_target_group"></a> [target\_group](#module\_target\_group) | ./target-group | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | n/a | `map` | `{}` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_connection_logs"></a> [connection\_logs](#input\_connection\_logs) | n/a | `map` | `{}` | no |
| <a name="input_customer_owned_ipv4_pool"></a> [customer\_owned\_ipv4\_pool](#input\_customer\_owned\_ipv4\_pool) | n/a | `any` | `null` | no |
| <a name="input_desync_mitigation_mode"></a> [desync\_mitigation\_mode](#input\_desync\_mitigation\_mode) | n/a | `any` | `null` | no |
| <a name="input_dns_record_client_routing_policy"></a> [dns\_record\_client\_routing\_policy](#input\_dns\_record\_client\_routing\_policy) | n/a | `any` | `null` | no |
| <a name="input_drop_invalid_header_fields"></a> [drop\_invalid\_header\_fields](#input\_drop\_invalid\_header\_fields) | n/a | `any` | `null` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | n/a | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | n/a | `any` | `null` | no |
| <a name="input_enable_tls_version_and_cipher_suite_headers"></a> [enable\_tls\_version\_and\_cipher\_suite\_headers](#input\_enable\_tls\_version\_and\_cipher\_suite\_headers) | n/a | `any` | `null` | no |
| <a name="input_enable_waf_fail_open"></a> [enable\_waf\_fail\_open](#input\_enable\_waf\_fail\_open) | n/a | `any` | `null` | no |
| <a name="input_enable_xff_client_port"></a> [enable\_xff\_client\_port](#input\_enable\_xff\_client\_port) | n/a | `any` | `null` | no |
| <a name="input_enforce_security_group_inbound_rules_on_private_link_traffic"></a> [enforce\_security\_group\_inbound\_rules\_on\_private\_link\_traffic](#input\_enforce\_security\_group\_inbound\_rules\_on\_private\_link\_traffic) | n/a | `any` | `null` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | n/a | `any` | `null` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | n/a | `any` | n/a | yes |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | n/a | `any` | `null` | no |
| <a name="input_listeners"></a> [listeners](#input\_listeners) | n/a | `map` | `{}` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | n/a | `any` | n/a | yes |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | n/a | `any` | `null` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_preserve_host_header"></a> [preserve\_host\_header](#input\_preserve\_host\_header) | n/a | `any` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | `any` | `null` | no |
| <a name="input_subnet_mapping"></a> [subnet\_mapping](#input\_subnet\_mapping) | n/a | `list` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_target_group_attachments"></a> [target\_group\_attachments](#input\_target\_group\_attachments) | n/a | `map` | `{}` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | n/a | `map` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | n/a | `map` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | `any` | n/a | yes |
| <a name="input_xff_header_processing_mode"></a> [xff\_header\_processing\_mode](#input\_xff\_header\_processing\_mode) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | n/a |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | n/a |
| <a name="output_listener_arn"></a> [listener\_arn](#output\_listener\_arn) | n/a |
| <a name="output_target_group"></a> [target\_group](#output\_target\_group) | n/a |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | n/a |
