#TODO: replace with product patch group
resource "aws_resourcegroups_group" "resource_group" {
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
        }
        {
            "Key": "Product",
            "Values": ["${var.tags["Product"]}"]
        }
    ]
}
JSON
  }
}