terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.21.0"
    }
  }
}
