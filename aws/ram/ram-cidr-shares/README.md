### Requirements

No requirements.

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_principal_association"></a> [principal\_association](#module\_principal\_association) | git::ssh://git@github.com/dicomgrid/pt-modules.git//aws/ram/principal_association | master |

### Resources

| Name | Type |
|------|------|
| [aws_ram_resource_association.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_subnet.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_ids"></a> [account\_ids](#input\_account\_ids) | The AWS Account ID numbers of the accounts with which you are sharing your subnet | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the subnets are located | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to be applied to all resources | `map(string)` | <pre>{<br>  "Creator": "Terraform",<br>  "Environment": "Production"<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to create resources in | `string` | `"us-east-2"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_filtered_subnets"></a> [filtered\_subnets](#output\_filtered\_subnets) | n/a |
| <a name="output_ram_principal_association"></a> [ram\_principal\_association](#output\_ram\_principal\_association) | n/a |
| <a name="output_ram_resource_association"></a> [ram\_resource\_association](#output\_ram\_resource\_association) | n/a |
| <a name="output_subnet_cidr_blocks"></a> [subnet\_cidr\_blocks](#output\_subnet\_cidr\_blocks) | n/a |
