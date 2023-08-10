<!-- BEGIN_TF_DOCS -->
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
| [aws_ec2_transit_gateway_peering_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_peering_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accepter_account_id"></a> [accepter\_account\_id](#input\_accepter\_account\_id) | n/a | `any` | `null` | no |
| <a name="input_accepter_region"></a> [accepter\_region](#input\_accepter\_region) | n/a | `any` | n/a | yes |
| <a name="input_accepter_transit_gateway"></a> [accepter\_transit\_gateway](#input\_accepter\_transit\_gateway) | n/a | `any` | n/a | yes |
| <a name="input_accepter_transit_gateway_id"></a> [accepter\_transit\_gateway\_id](#input\_accepter\_transit\_gateway\_id) | n/a | `any` | n/a | yes |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_requester_routes"></a> [requester\_routes](#input\_requester\_routes) | n/a | `list` | `[]` | no |
| <a name="input_requester_transit_gateway"></a> [requester\_transit\_gateway](#input\_requester\_transit\_gateway) | n/a | `any` | n/a | yes |
| <a name="input_requester_transit_gateway_id"></a> [requester\_transit\_gateway\_id](#input\_requester\_transit\_gateway\_id) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_attachment"></a> [attachment](#output\_attachment) | n/a |
<!-- END_TF_DOCS -->