resource "aws_resourcegroups_group" "resource_group" {
  tags        = var.tags
  name        = "${var.tags["client_code"]}-${lower(var.tags["Platform Type"])}-${var.resource_group}"
  description = "${var.tags["client_code"]}-${lower(var.tags["Platform Type"])}-${var.resource_group}"
  resource_query {
    query = <<JSON
    {
      "ResourceTypeFilters": [
        "AWS::EC2::Instance",
        "AWS::SSM::ManagedInstance"
      ],
      "TagFilters": [
        {
          "Key": "${startswith(var.tags["client_code"], "default") ? "maintenance_window" : "client_code"}",
          "Values": ["${var.tags["client_code"]}"]
        },
        {
          "Key": "Platform Type",
          "Values": ["${var.tags["Platform Type"]}"]
        },
        {
          "Key": "resource_group",
          "Values": ["${var.resource_group}"]
        },
        {
          "Key": "patching_status",
          "Values": ["enabled"]
        }
      ]
    }
  JSON
  }
}
