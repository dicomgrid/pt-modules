## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Resources

| Name | Type |
|------|------|
| [aws_resourcegroups_group.resource_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of resource group | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Resource Group Name | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource Group Tags | `map(string)` | <pre>{<br>  "Customer": "",<br>  "Group": "",<br>  "OS": ""<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource-group-arn"></a> [resource-group-arn](#output\_resource-group-arn) | n/a |
