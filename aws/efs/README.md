<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_backup_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_backup_policy) | resource |
| [aws_efs_file_system.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `""` | no |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `any` | `null` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | n/a | `string` | `"ENABLED"` | no |
| <a name="input_backups"></a> [backups](#input\_backups) | n/a | `any` | `null` | no |
| <a name="input_billing"></a> [billing](#input\_billing) | n/a | `string` | `""` | no |
| <a name="input_codemanaged"></a> [codemanaged](#input\_codemanaged) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | n/a | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | n/a | `any` | `null` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `any` | `null` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `any` | `null` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | `"platform"` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | maxIO or generalPurpose | `string` | `"generalPurpose"` | no |
| <a name="input_product"></a> [product](#input\_product) | n/a | `string` | `"ambra"` | no |
| <a name="input_provisioned_throughput_in_mibps"></a> [provisioned\_throughput\_in\_mibps](#input\_provisioned\_throughput\_in\_mibps) | n/a | `any` | `null` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | bursting or provisioned | `string` | `"bursting"` | no |
| <a name="input_transition_to_ia"></a> [transition\_to\_ia](#input\_transition\_to\_ia) | AFTER\_30\_DAYS, AFTER\_60\_DAYS, AFTER\_90\_DAYS | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns"></a> [dns](#output\_dns) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->