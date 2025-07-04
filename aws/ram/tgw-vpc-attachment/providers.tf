terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.64.0"
      configuration_aliases = [aws.accepter, aws.requester]
    }
  }
}

