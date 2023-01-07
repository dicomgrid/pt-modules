## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_patch_baseline.pb-linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_baseline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of patch baseline | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | name of patch baseline | `string` | `""` | no |
| <a name="input_rejected_patches"></a> [rejected\_patches](#input\_rejected\_patches) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pb-linux-arn"></a> [pb-linux-arn](#output\_pb-linux-arn) | n/a |
| <a name="output_pb-linux-id"></a> [pb-linux-id](#output\_pb-linux-id) | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_patch_baseline.pb-linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_baseline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of patch baseline | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | name of patch baseline | `string` | `""` | no |
| <a name="input_rejected_patches"></a> [rejected\_patches](#input\_rejected\_patches) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pb-linux-arn"></a> [pb-linux-arn](#output\_pb-linux-arn) | n/a |
| <a name="output_pb-linux-id"></a> [pb-linux-id](#output\_pb-linux-id) | n/a |
<!-- END_TF_DOCS -->