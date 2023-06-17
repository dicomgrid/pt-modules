terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.21.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.15.2"
    }
  }
}