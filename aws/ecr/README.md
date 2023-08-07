<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_aws_project_id"></a> [aws\_project\_id](#input\_aws\_project\_id) | n/a | `string` | `"null"` | no |
| <a name="input_code_managed"></a> [code\_managed](#input\_code\_managed) | n/a | `string` | `"true"` | no |
| <a name="input_compliance"></a> [compliance](#input\_compliance) | n/a | `string` | `"null"` | no |
| <a name="input_cross_account_access"></a> [cross\_account\_access](#input\_cross\_account\_access) | n/a | `bool` | `false` | no |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | n/a | `string` | `"AES256"` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE. | `string` | `"MUTABLE"` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | ARN of the KMS to use when encryption type is KMS | `string` | `null` | no |
| <a name="input_lifecycle_policy"></a> [lifecycle\_policy](#input\_lifecycle\_policy) | n/a | `string` | `"default"` | no |
| <a name="input_lifecycle_policy_default"></a> [lifecycle\_policy\_default](#input\_lifecycle\_policy\_default) | n/a | `string` | `"{\n  \"rules\": [\n    {\n      \"rulePriority\": 10,\n      \"description\": \"Expire older final releases\",\n      \"selection\": {\n          \"tagStatus\": \"tagged\",\n          \"tagPrefixList\": [\"final\"],\n          \"countType\": \"sinceImagePushed\",\n          \"countUnit\": \"days\",\n          \"countNumber\": 90\n      },\n      \"action\": {\n          \"type\": \"expire\"\n      }\n    },\n    {\n      \"rulePriority\": 11,\n      \"description\": \"Expire older rc\",\n      \"selection\": {\n          \"tagStatus\": \"tagged\",\n          \"tagPrefixList\": [\"rc\"],\n          \"countType\": \"sinceImagePushed\",\n          \"countUnit\": \"days\",\n          \"countNumber\": 14\n      },\n      \"action\": {\n          \"type\": \"expire\"\n      }\n    },\n    {\n      \"rulePriority\": 12,\n      \"description\": \"Expire older dev images\",\n      \"selection\": {\n          \"tagStatus\": \"tagged\",\n          \"tagPrefixList\": [\"dev\"],\n          \"countType\": \"sinceImagePushed\",\n          \"countUnit\": \"days\",\n          \"countNumber\": 14\n      },\n      \"action\": {\n          \"type\": \"expire\"\n      }\n    },\n    {\n      \"rulePriority\": 13,\n      \"description\": \"Expire dirty images\",\n      \"selection\": {\n          \"tagStatus\": \"tagged\",\n          \"tagPrefixList\": [\"dirty\"],\n          \"countType\": \"sinceImagePushed\",\n          \"countUnit\": \"days\",\n          \"countNumber\": 1\n      },\n      \"action\": {\n          \"type\": \"expire\"\n      }\n    },\n    {\n      \"rulePriority\": 14,\n      \"description\": \"Expire untagged >1w old\",\n      \"selection\": {\n        \"tagStatus\": \"untagged\",\n        \"countType\": \"sinceImagePushed\",\n        \"countUnit\": \"days\",\n        \"countNumber\": 1\n      },\n      \"action\": {\n          \"type\": \"expire\"\n      }\n    }\n  ]\n}\n"` | no |
| <a name="input_lifecycle_policy_enable"></a> [lifecycle\_policy\_enable](#input\_lifecycle\_policy\_enable) | n/a | `bool` | `true` | no |
| <a name="input_map_migrated"></a> [map\_migrated](#input\_map\_migrated) | n/a | `string` | `"null"` | no |
| <a name="input_onetime"></a> [onetime](#input\_onetime) | n/a | `string` | `"null"` | no |
| <a name="input_pull_roles"></a> [pull\_roles](#input\_pull\_roles) | Role ARN's that have read-only access | `list(string)` | `[]` | no |
| <a name="input_pull_service_identifiers"></a> [pull\_service\_identifiers](#input\_pull\_service\_identifiers) | Service identifiers that have read-only access | `list(string)` | `[]` | no |
| <a name="input_push_roles"></a> [push\_roles](#input\_push\_roles) | Role ARN's that have read/write access | `list(string)` | `[]` | no |
| <a name="input_push_service_identifiers"></a> [push\_service\_identifiers](#input\_push\_service\_identifiers) | Service identifiers that have read/write access | `list(string)` | `[]` | no |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Enable image scanning on push | `string` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_permissions"></a> [permissions](#output\_permissions) | n/a |
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | n/a |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | n/a |
<!-- END_TF_DOCS -->