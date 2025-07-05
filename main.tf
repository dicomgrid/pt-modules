terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = ">= 1.0.0"
    }
    opensearch = {
      source  = "opensearch-project/opensearch"
      version = "~> 2.2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "bedrock_knowledge_base" {
  source = "../../"

  name_prefix = "basic-kb-example"
  
  kb_description = "Basic knowledge base example"
  
  # Enable logging for monitoring
  enable_logging = true
  log_retention_days = 7
  
  tags = {
    Environment = "example"
    Project     = "bedrock-kb-basic"
    Purpose     = "demonstration"
  }
}
