### Requirements

No requirements.

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_ids"></a> [account\_ids](#input\_account\_ids) | The AWS Account ID numbers of the accounts with which you are sharing your subnet | `list(string)` | n/a | yes |
| <a name="input_resource_share_arn"></a> [resource\_share\_arn](#input\_resource\_share\_arn) | The ARN of the resource share | `string` | n/a | yes |

### Outputs

No outputs.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_principals"></a> [principals](#input\_principals) | The principals to associate with the resource share. AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN. | `list(string)` | n/a | yes |
| <a name="input_resource_share_arn"></a> [resource\_share\_arn](#input\_resource\_share\_arn) | The ARN of the resource share | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_principal"></a> [principal](#output\_principal) | n/a |
| <a name="output_resource_share_arn"></a> [resource\_share\_arn](#output\_resource\_share\_arn) | n/a |
<!-- END_TF_DOCS -->