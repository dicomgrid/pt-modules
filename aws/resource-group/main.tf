resource "aws_resourcegroups_group" "resource_group" {
  tags        = var.tags
  name        = var.name
  description = var.description
  resource_query {
    query = var.resource_query
  }
}