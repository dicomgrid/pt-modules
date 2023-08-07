<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_instances.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instances) | data source |
| [aws_security_groups.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_groups) | data source |
| [aws_subnets.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_internal"></a> [internal](#input\_internal) | n/a | `any` | n/a | yes |
| <a name="input_listener_action_type"></a> [listener\_action\_type](#input\_listener\_action\_type) | n/a | `any` | n/a | yes |
| <a name="input_listener_port"></a> [listener\_port](#input\_listener\_port) | n/a | `any` | n/a | yes |
| <a name="input_listener_protocol"></a> [listener\_protocol](#input\_listener\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | n/a | `any` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_target_instances"></a> [target\_instances](#input\_target\_instances) | n/a | `any` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | n/a | `any` | n/a | yes |
| <a name="input_target_protocol"></a> [target\_protocol](#input\_target\_protocol) | n/a | `any` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | `any` | n/a | yes |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | n/a | `bool` | `true` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | `list` | <pre>[<br>  {<br>    "healthy_threshold": null,<br>    "interval": null,<br>    "matcher": null,<br>    "path": null,<br>    "port": null,<br>    "timeout": null,<br>    "unhealthy_threshold": null<br>  }<br>]</pre> | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | `any` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->