terraform {
  backend "s3" {
    bucket         = "sre-inf-prod-tfstate"
    region         = "us-east-2"
    role_arn       = "arn:aws:iam::601722232065:role/sre-inf_cross_account"
    key            = "Development/Platform/HashiVault/terraform-remote-state/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "TFState"
  }

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

provider "aws" {
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::601722232065:role/sre-inf_cross_account"
    session_name = "vault"
    external_id  = "vault"
  }
}

provider "vault" {
  address          = var.vault_address
  namespace        = var.vault_namespace
}
