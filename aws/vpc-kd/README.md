## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network_acl"></a> [network\_acl](#module\_network\_acl) | ./network-acl | n/a |
| <a name="module_shared-vpc-subnets"></a> [shared-vpc-subnets](#module\_shared-vpc-subnets) | ./shared-vpc-subnets | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |
| <a name="module_vpc-elastic-ip"></a> [vpc-elastic-ip](#module\_vpc-elastic-ip) | ./eip | n/a |
| <a name="module_vpc-explicit-route-tables"></a> [vpc-explicit-route-tables](#module\_vpc-explicit-route-tables) | ./vpc-route-table | n/a |
| <a name="module_vpc-explicit-route-tables-associations"></a> [vpc-explicit-route-tables-associations](#module\_vpc-explicit-route-tables-associations) | ./route_table_association | n/a |
| <a name="module_vpc-internet-gateway"></a> [vpc-internet-gateway](#module\_vpc-internet-gateway) | ./internet_gateway | n/a |
| <a name="module_vpc-nat-gateway"></a> [vpc-nat-gateway](#module\_vpc-nat-gateway) | ./nat_gateway | n/a |
| <a name="module_vpc-subnets"></a> [vpc-subnets](#module\_vpc-subnets) | ./subnet | n/a |
| <a name="module_vpc_cidr_block_association"></a> [vpc\_cidr\_block\_association](#module\_vpc\_cidr\_block\_association) | ./vpc_cidr_block_association | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_share.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_vpc_dhcp_options_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dhcp-options-set-ids"></a> [dhcp-options-set-ids](#input\_dhcp-options-set-ids) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | <pre>{<br>  "Billing": "IT",<br>  "Enviroment": "prod",<br>  "OneTime": null,<br>  "Owner": "IT",<br>  "Product": "Network",<br>  "aws-migration-project-id": "MPE24884",<br>  "map-migrated": "d-server-01d6zedrzy7814"<br>}</pre> | no |
| <a name="input_vpc-details"></a> [vpc-details](#input\_vpc-details) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_shared_aws_accounts"></a> [shared\_aws\_accounts](#output\_shared\_aws\_accounts) | n/a |
