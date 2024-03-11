<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_volume_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_ami.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.centos7](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.rhel_8](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.rocky_8](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.rocky_8_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu_22_04](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.windows_2019_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.windows_server_2016](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.windows_server_2016_sql_2017](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.windows_server_2019](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_security_groups.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_groups) | data source |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `any` | n/a | yes |
| <a name="input_ebs_block_devices"></a> [ebs\_block\_devices](#input\_ebs\_block\_devices) | n/a | `any` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | n/a | `any` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | `any` | n/a | yes |
| <a name="input_ami"></a> [ami](#input\_ami) | n/a | `string` | `"rocky_8_custom"` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | n/a | `string` | `"false"` | no |
| <a name="input_ebs_block_devices_extra"></a> [ebs\_block\_devices\_extra](#input\_ebs\_block\_devices\_extra) | n/a | `any` | `null` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | n/a | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | n/a | `map` | <pre>{<br>  "c5_12xlarge_accelerator": "c5.12xlarge",<br>  "c5_xlarge": "c5.xlarge",<br>  "fullstack_privatecloud": "r5.4xlarge",<br>  "m5_2xlarge": "m5.2xlarge",<br>  "m5_4xlarge": "m5.4xlarge",<br>  "m6a_2xlarge": "m6a.2xlarge",<br>  "medium_accelerator": "c5.4xlarge",<br>  "medium_gateway": "c5.9xlarge",<br>  "powerscribe360": "m4.xlarge",<br>  "r5_8xlarge_accelerator": "r5.8xlarge",<br>  "r5_xlarge": "r5.xlarge",<br>  "small_accelerator": "c5.2xlarge",<br>  "small_gateway": "c5.2xlarge",<br>  "small_privatecloud": "c5.2xlarge",<br>  "t3_large": "t3.large"<br>}</pre> | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"ansible-rsa"` | no |
| <a name="input_local_password"></a> [local\_password](#input\_local\_password) | n/a | `any` | `null` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | n/a | `any` | `null` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | n/a | `list` | <pre>[<br>  {<br>    "delete_on_termination": null,<br>    "encrypted": null,<br>    "iops": null,<br>    "throughput": null,<br>    "volume_size": null,<br>    "volume_type": null<br>  }<br>]</pre> | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | `list` | `[]` | no |
| <a name="input_server_code"></a> [server\_code](#input\_server\_code) | n/a | `any` | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
<!-- END_TF_DOCS -->