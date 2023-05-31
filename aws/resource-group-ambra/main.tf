resource "aws_resourcegroups_group" "resource_group" {
  tags        = var.tags
  name        = var.name
  description = var.description

  resource_query {
    query = <<JSON #TODO: Make filter dynamic based on provided tag input
{
    "ResourceTypeFilters": ["AWS::SSM::ManagedInstance"],
    "TagFilters": [
        {
            "Key": "Environment",
            "Values": ["${var.tags["Environment"]}"]
        },
        {
            "Key": "Product",
            "Values": ["${var.tags["Product"]}"]
        },
        {
            "Key": "Patch_Group",
            "Values": ["${var.tags["Patch_Group"]}"]
        }
    ]
}
JSON
  }
}