terraform {
  backend "s3" {
    bucket         = "sre-inf-prod-tfstate"
    region         = "us-east-2"
    role_arn       = "arn:aws:iam::601722232065:role/sre-inf_cross_account"
    key            = "SSM/Development/IMSMSO-new/terraform-remote-state/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "TFState"
  }
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.21.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::601722232065:role/sre-inf_cross_account"
    session_name = "ssm-patch-automation"
    external_id  = "SSM-IMSMSO"
  }
}