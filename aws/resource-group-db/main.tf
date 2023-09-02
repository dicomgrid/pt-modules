#TODO: verify not used and delete moduleresource "aws_resourcegroups_group" "resource_group" {
  tags        = var.tags
  name        = var.name
  description = var.description
  resource_query {
    query = <<JSON
{
    "ResourceTypeFilters": ["AWS::SSM::ManagedInstance"],
    "TagFilters": [
        {
            "Key": "Customer",
            "Values": ["${var.tags["Customer"]}"]
        },
        {
            "Key": "Group",
            "Values": ["${var.tags["Group"]}"]
        },
        {
            "Key": "isDB",
            "Values": ["${var.tags["isDB"]}"]
        }
    ]
}
JSON

  }

}

