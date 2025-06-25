# Module Name

Brief description of what this module does.

## Usage

```hcl
module "example" {
  source = "path/to/this/module"
  
  name = "example-resource"
  
  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
```

## Examples

- [Basic Example](./examples/basic/) - Simple usage example

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| provider | >= 1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| resource | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the resource | `string` | n/a | yes |
| tags | A map of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the created resource |
| name | The name of the created resource |
