<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_patch_group.ssm_patch_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_baseline_id"></a> [baseline\_id](#input\_baseline\_id) | Patch Baseline ID. Default OS Agnostic profile is pb-020d361a05defe4ed | `string` | `""` | no |
| <a name="input_patch_group"></a> [patch\_group](#input\_patch\_group) | n/a | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->