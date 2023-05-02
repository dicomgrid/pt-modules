variable "lifecycle_policy_default" {
  default = <<EOF
{
  "rules": [
    {
      "rulePriority": 10,
      "description": "Expire older final releases",
      "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["final"],
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 90
      },
      "action": {
          "type": "expire"
      }
    },
    {
      "rulePriority": 11,
      "description": "Expire older rc",
      "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["rc"],
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 14
      },
      "action": {
          "type": "expire"
      }
    },
    {
      "rulePriority": 12,
      "description": "Expire older dev images",
      "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["dev"],
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 14
      },
      "action": {
          "type": "expire"
      }
    },
    {
      "rulePriority": 13,
      "description": "Expire dirty images",
      "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["dirty"],
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 1
      },
      "action": {
          "type": "expire"
      }
    },
    {
      "rulePriority": 14,
      "description": "Expire untagged >1w old",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 1
      },
      "action": {
          "type": "expire"
      }
    }
  ]
}
EOF
}