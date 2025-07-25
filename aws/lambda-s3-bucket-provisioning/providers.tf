terraform {
  required_version = ">= 1.0.9"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 4.47.0"
      configuration_aliases = [aws.primary, aws.ambra_storage1_account]
    }
  }
}