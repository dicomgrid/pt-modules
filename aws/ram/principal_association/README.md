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
