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
| <a name="input_approval_day_count"></a> [approval\_day\_count](#input\_approval\_day\_count) | n/a | `string` | `7` | no |
| <a name="input_centos_patch_classifications"></a> [centos\_patch\_classifications](#input\_centos\_patch\_classifications) | n/a | `list(string)` | <pre>[<br>  "Security",<br>  "Bugfix",<br>  "Recommended"<br>]</pre> | no |
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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_patch_baseline.centos-pb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_baseline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approval_days"></a> [approval\_days](#input\_approval\_days) | n/a | `number` | `7` | no |
| <a name="input_approved_patches"></a> [approved\_patches](#input\_approved\_patches) | n/a | `any` | `null` | no |
| <a name="input_compliance_levels"></a> [compliance\_levels](#input\_compliance\_levels) | n/a | <pre>list(object({<br>    <br>    compliance_level = string<br>    severity = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "compliance_level": "CRITICAL",<br>    "severity": [<br>      "Critical",<br>      "Important"<br>    ]<br>  },<br>  {<br>    "compliance_level": "MEDIUM",<br>    "severity": [<br>      "Moderate"<br>    ]<br>  },<br>  {<br>    "compliance_level": "LOW",<br>    "severity": [<br>      "Low"<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"null"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"null"` | no |
| <a name="input_patch_classifications"></a> [patch\_classifications](#input\_patch\_classifications) | n/a | `list` | <pre>[<br>  "Security",<br>  "Bugfix",<br>  "Recommended"<br>]</pre> | no |
| <a name="input_rejected_patches"></a> [rejected\_patches](#input\_rejected\_patches) | n/a | `any` | `null` | no |
| <a name="input_source_repos"></a> [source\_repos](#input\_source\_repos) | n/a | <pre>list(object({<br>    name = string<br>    products = list(string)<br>    configuration = string<br>  }))</pre> | <pre>[<br>  {<br>    "configuration": "[base]\nname=CentOS-$releasever - Base\n#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os&infra=$infra\nbaseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/\ngpgcheck=1\ngpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7\n",<br>    "name": "base",<br>    "products": [<br>      "CentOS7.0",<br>      "CentOS7.1",<br>      "CentOS7.2",<br>      "CentOS7.3",<br>      "CentOS7.4",<br>      "CentOS7.5",<br>      "CentOS7.6",<br>      "CentOS7.7",<br>      "CentOS7.8",<br>      "CentOS7.9"<br>    ]<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_centos-pb-arn"></a> [centos-pb-arn](#output\_centos-pb-arn) | n/a |
| <a name="output_centos-pb-id"></a> [centos-pb-id](#output\_centos-pb-id) | n/a |
<!-- END_TF_DOCS -->