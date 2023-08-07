<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_resourcegroups_group.resource_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of resource group | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Resource Group Name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource Group Tags | `map(string)` | <pre>{<br>  "Customer": "",<br>  "Datacenter": "",<br>  "Product": ""<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource-group-arn"></a> [resource-group-arn](#output\_resource-group-arn) | n/a |
<!-- END_TF_DOCS -->