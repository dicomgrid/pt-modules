<!-- BEGIN_TF_DOCS -->
### Requirements

Use "enable" boolean variables to enable/disable that particular log source. ie to enable just flow logs for each ENI
set: 

enable-eni-logs = true

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_enable-eni-logs"></a> [enable-eni-logs](#module\_enable-eni-logs) | ./enable-eni-logs | n/a |
| <a name="module_enable-subnet-logs"></a> [enable-subnet-logs](#module\_enable-subnet-logs) | ./enable-subnet-logs | n/a |
| <a name="module_enable-tgw-attachment-logs"></a> [enable-tgw-attachment-logs](#module\_enable-tgw-attachment-logs) | ./enable-tgw-attachment-logs | n/a |
| <a name="module_enable-vpc-logs"></a> [enable-vpc-logs](#module\_enable-vpc-logs) | ./enable-vpc-logs | n/a |

### Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.log_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ec2_transit_gateway_attachments.attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_attachments) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `any` | n/a | yes |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_log_destination"></a> [log\_destination](#input\_log\_destination) | n/a | `any` | n/a | yes |
| <a name="input_max_aggregation_interval"></a> [max\_aggregation\_interval](#input\_max\_aggregation\_interval) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |
| <a name="input_LogDeliveryEnabled"></a> [LogDeliveryEnabled](#input\_LogDeliveryEnabled) | n/a | `bool` | `true` | no |
| <a name="input_codemanaged"></a> [codemanaged](#input\_codemanaged) | n/a | `string` | `"Terraform"` | no |
| <a name="input_enable-eni-logs"></a> [enable-eni-logs](#input\_enable-eni-logs) | n/a | `bool` | `false` | no |
| <a name="input_enable-subnet-logs"></a> [enable-subnet-logs](#input\_enable-subnet-logs) | n/a | `bool` | `false` | no |
| <a name="input_enable-tgw-attachment-logs"></a> [enable-tgw-attachment-logs](#input\_enable-tgw-attachment-logs) | n/a | `bool` | `false` | no |
| <a name="input_enable-vpc-logs"></a> [enable-vpc-logs](#input\_enable-vpc-logs) | n/a | `bool` | `false` | no |
| <a name="input_log_destination_type"></a> [log\_destination\_type](#input\_log\_destination\_type) | n/a | `string` | `"cloud-watch-logs"` | no |
| <a name="input_log_source"></a> [log\_source](#input\_log\_source) | n/a | `string` | `"vpc"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | n/a | `number` | `180` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

### Outputs

No outputs.
<!-- END_TF_DOCS -->