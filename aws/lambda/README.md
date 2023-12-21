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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_function.lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | n/a | `any` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | n/a | `any` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | n/a | `any` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | n/a | `any` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | n/a | `any` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | n/a | `string` | `""` | no |
| <a name="input_source_code_filename"></a> [source\_code\_filename](#input\_source\_code\_filename) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | n/a |
