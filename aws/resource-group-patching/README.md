<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_resourcegroups_group.resource_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource Group Tags | `map(string)` | <pre>{<br>  "Platform Type": "",<br>  "client_code": ""<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource-group-arn"></a> [resource-group-arn](#output\_resource-group-arn) | n/a |
<!-- END_TF_DOCS -->