terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.30.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "4.2.0"
    }
  }
}
