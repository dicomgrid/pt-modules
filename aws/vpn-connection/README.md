<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpn_connection.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_customer_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/customer_gateway) | data source |
| [aws_vpn_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpn_gateway) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_subnets"></a> [aws\_subnets](#input\_aws\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_customer_gateway_name"></a> [customer\_gateway\_name](#input\_customer\_gateway\_name) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_p1_dh_group_numbers"></a> [p1\_dh\_group\_numbers](#input\_p1\_dh\_group\_numbers) | n/a | `any` | n/a | yes |
| <a name="input_p2_dh_group_numbers"></a> [p2\_dh\_group\_numbers](#input\_p2\_dh\_group\_numbers) | n/a | `any` | n/a | yes |
| <a name="input_preshared_key"></a> [preshared\_key](#input\_preshared\_key) | n/a | `any` | n/a | yes |
| <a name="input_remote_subnets"></a> [remote\_subnets](#input\_remote\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_vpn_gateway"></a> [vpn\_gateway](#input\_vpn\_gateway) | n/a | `any` | n/a | yes |
| <a name="input_creator"></a> [creator](#input\_creator) | n/a | `string` | `"Terraform"` | no |
| <a name="input_dpd_timeout"></a> [dpd\_timeout](#input\_dpd\_timeout) | n/a | `string` | `"30"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"Production"` | no |
| <a name="input_ike_version"></a> [ike\_version](#input\_ike\_version) | n/a | `list` | <pre>[<br>  "ikev2"<br>]</pre> | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | `"Platform"` | no |
| <a name="input_p1_encryption"></a> [p1\_encryption](#input\_p1\_encryption) | n/a | `list` | <pre>[<br>  "AES256"<br>]</pre> | no |
| <a name="input_p1_integrity_algorithms"></a> [p1\_integrity\_algorithms](#input\_p1\_integrity\_algorithms) | n/a | `list(string)` | <pre>[<br>  "SHA2-256",<br>  "SHA2-384",<br>  "SHA2-512"<br>]</pre> | no |
| <a name="input_p2_encryption"></a> [p2\_encryption](#input\_p2\_encryption) | n/a | `list` | <pre>[<br>  "AES256"<br>]</pre> | no |
| <a name="input_p2_integrity_algorithms"></a> [p2\_integrity\_algorithms](#input\_p2\_integrity\_algorithms) | n/a | `list(string)` | <pre>[<br>  "SHA2-256",<br>  "SHA2-384",<br>  "SHA2-512"<br>]</pre> | no |
| <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type) | n/a | `string` | `"ipsec.1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->