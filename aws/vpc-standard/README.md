<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/resources/internet_gateway) | resource |
| [aws_route_table.igw_rt](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/resources/route_table) | resource |
| [aws_route_table_association.a](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/resources/route_table_association) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/resources/vpc) | resource |
| [aws_availability_zones.availability_zones](https://registry.terraform.io/providers/hashicorp/aws/4.38.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Billing"></a> [Billing](#input\_Billing) | n/a | `string` | `""` | no |
| <a name="input_Creator"></a> [Creator](#input\_Creator) | n/a | `string` | `"Terraform"` | no |
| <a name="input_Environment"></a> [Environment](#input\_Environment) | n/a | `string` | `"Production"` | no |
| <a name="input_Owner"></a> [Owner](#input\_Owner) | n/a | `string` | `"Platform"` | no |
| <a name="input_dns_hostnames"></a> [dns\_hostnames](#input\_dns\_hostnames) | n/a | `bool` | `true` | no |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | n/a | `bool` | `true` | no |
| <a name="input_tenancy"></a> [tenancy](#input\_tenancy) | n/a | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->