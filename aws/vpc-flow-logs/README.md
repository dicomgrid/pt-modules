<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_enable-eni-logs"></a> [enable-eni-logs](#module\_enable-eni-logs) | ./enable-eni-logs | n/a |
| <a name="module_enable-subnet-logs"></a> [enable-subnet-logs](#module\_enable-subnet-logs) | ./enable-subnet-logs | n/a |
| <a name="module_enable-tgw-attachment-logs"></a> [enable-tgw-attachment-logs](#module\_enable-tgw-attachment-logs) | ./enable-tgw-attachment-logs | n/a |
| <a name="module_enable-vpc-logs"></a> [enable-vpc-logs](#module\_enable-vpc-logs) | ./enable-vpc-logs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.log_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ec2_transit_gateway_attachments.attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_attachments) | data source |
| [aws_subnets.get_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | n/a | `any` | n/a | yes |
| <a name="input_log_destination"></a> [log\_destination](#input\_log\_destination) | n/a | `any` | n/a | yes |
| <a name="input_max_aggregation_interval"></a> [max\_aggregation\_interval](#input\_max\_aggregation\_interval) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | `""` | no |
| <a name="input_enable-eni-logs"></a> [enable-eni-logs](#input\_enable-eni-logs) | n/a | `bool` | `false` | no |
| <a name="input_enable-subnet-logs"></a> [enable-subnet-logs](#input\_enable-subnet-logs) | n/a | `bool` | `false` | no |
| <a name="input_enable-tgw-attachment-logs"></a> [enable-tgw-attachment-logs](#input\_enable-tgw-attachment-logs) | n/a | `bool` | `false` | no |
| <a name="input_enable-vpc-logs"></a> [enable-vpc-logs](#input\_enable-vpc-logs) | n/a | `bool` | `false` | no |
| <a name="input_log_destination_type"></a> [log\_destination\_type](#input\_log\_destination\_type) | n/a | `string` | `"cloud-watch-logs"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | n/a | `number` | `180` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | The ARN of the CloudWatch log group. |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The name of the CloudWatch log group. |
| <a name="output_log_stream_name"></a> [log\_stream\_name](#output\_log\_stream\_name) | The name of the CloudWatch log stream. |
<!-- END_TF_DOCS -->