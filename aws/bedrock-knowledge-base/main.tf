# AWS Bedrock Knowledge Base with Vector Search
# This module creates a comprehensive knowledge base infrastructure using:
# - Amazon Bedrock Knowledge Base for RAG (Retrieval-Augmented Generation)
# - OpenSearch Serverless for vector storage
# - S3 bucket for document storage
# - IAM roles and policies for secure access

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

# Get current AWS account info
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Generate random suffix for unique resource names
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  name_prefix = var.name_prefix != null ? var.name_prefix : "kb-${random_string.suffix.result}"
  
  tags = merge(var.tags, {
    Module = "bedrock-knowledge-base"
    ManagedBy = "Terraform"
  })
}

# S3 bucket for storing documents
resource "aws_s3_bucket" "knowledge_base_documents" {
  bucket = "${local.name_prefix}-documents"
  tags   = local.tags
}

resource "aws_s3_bucket_versioning" "knowledge_base_documents" {
  bucket = aws_s3_bucket.knowledge_base_documents.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "knowledge_base_documents" {
  bucket = aws_s3_bucket.knowledge_base_documents.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.enable_s3_kms_encryption ? "aws:kms" : "AES256"
      kms_master_key_id = var.enable_s3_kms_encryption ? var.kms_key_id : null
    }
    bucket_key_enabled = var.enable_s3_kms_encryption
  }
}

resource "aws_s3_bucket_public_access_block" "knowledge_base_documents" {
  bucket = aws_s3_bucket.knowledge_base_documents.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 access logging (optional)
resource "aws_s3_bucket_logging" "knowledge_base_documents" {
  count = var.enable_s3_access_logging ? 1 : 0
  
  bucket = aws_s3_bucket.knowledge_base_documents.id

  target_bucket = var.s3_access_log_bucket
  target_prefix = var.s3_access_log_prefix
}

# S3 lifecycle policy (optional)
resource "aws_s3_bucket_lifecycle_configuration" "knowledge_base_documents" {
  count = var.enable_s3_lifecycle_policy ? 1 : 0
  
  bucket = aws_s3_bucket.knowledge_base_documents.id

  rule {
    id     = "knowledge_base_lifecycle"
    status = "Enabled"

    transition {
      days          = var.s3_lifecycle_transition_days
      storage_class = "STANDARD_IA"
    }

    dynamic "expiration" {
      for_each = var.s3_lifecycle_expiration_days > 0 ? [1] : []
      content {
        days = var.s3_lifecycle_expiration_days
      }
    }

    noncurrent_version_transition {
      noncurrent_days = var.s3_lifecycle_transition_days
      storage_class   = "STANDARD_IA"
    }

    dynamic "noncurrent_version_expiration" {
      for_each = var.s3_lifecycle_expiration_days > 0 ? [1] : []
      content {
        noncurrent_days = var.s3_lifecycle_expiration_days + 30
      }
    }
  }
}

# Use the AWS-IA Bedrock module for the knowledge base
module "bedrock_knowledge_base" {
  source = "aws-ia/bedrock/aws"
  version = "~> 0.0.28"

  # Agent configuration (optional - set to false if you only want knowledge base)
  create_agent = var.create_agent
  foundation_model = var.foundation_model
  instruction = var.agent_instruction

  # Knowledge Base configuration
  create_default_kb = true
  create_s3_data_source = true
  kb_s3_data_source = aws_s3_bucket.knowledge_base_documents.arn
  
  kb_name = "${local.name_prefix}-knowledge-base"
  kb_description = var.kb_description
  kb_embedding_model_arn = var.embedding_model_arn
  
  # Vector configuration
  vector_dimension = var.vector_dimension
  embedding_model_dimensions = var.embedding_model_dimensions
  embedding_data_type = var.embedding_data_type
  
  # Data source configuration
  data_deletion_policy = var.data_deletion_policy
  s3_inclusion_prefixes = var.s3_inclusion_prefixes
  
  # Chunking strategy
  chunking_strategy = var.chunking_strategy
  chunking_strategy_max_tokens = var.chunking_strategy_max_tokens
  chunking_strategy_overlap_percentage = var.chunking_strategy_overlap_percentage
  
  # Vector ingestion configuration
  create_vector_ingestion_configuration = var.enable_vector_ingestion_configuration
  create_parsing_configuration = var.enable_parsing_configuration
  parsing_strategy = var.parsing_strategy
  
  # OpenSearch Serverless configuration
  create_opensearch_config = false  # We'll use the default collection
  allow_opensearch_public_access = var.allow_opensearch_public_access
  number_of_shards = var.number_of_shards
  number_of_replicas = var.number_of_replicas
  
  # Logging
  create_kb_log_group = var.enable_logging
  kb_log_group_retention_in_days = var.log_retention_days
  
  # Tags
  kb_tags = local.tags
  tags = local.tags
  
  depends_on = [
    aws_s3_bucket.knowledge_base_documents,
    aws_s3_bucket_server_side_encryption_configuration.knowledge_base_documents,
  ]
}

# Use the AWS-IA OpenSearch Serverless module for vector search
module "opensearch_serverless" {
  source = "aws-ia/opensearch-serverless/aws"
  version = "~> 0.0.4"
  
  # Create vector index for the knowledge base
  create_vector_index = var.create_vector_index
  
  # Vector index configuration
  index_knn_algo_param_ef_search = var.index_knn_algo_param_ef_search
  number_of_shards = var.number_of_shards
  number_of_replicas = var.number_of_replicas
  
  # Vector index mappings for Bedrock compatibility
  vector_index_mappings = var.custom_vector_mappings != null ? var.custom_vector_mappings : jsonencode({
    "properties": {
      "bedrock-knowledge-base-default-vector": {
        "type": "knn_vector",
        "dimension": var.vector_dimension,
        "method": {
          "name": "hnsw",
          "space_type": "l2",
          "engine": "nmslib",
          "parameters": {
            "ef_construction": 512,
            "m": 16
          }
        }
      },
      "AMAZON_BEDROCK_METADATA": {
        "type": "text",
        "index": false
      },
      "AMAZON_BEDROCK_TEXT_CHUNK": {
        "type": "text"
      }
    }
  })
  
  # Network access
  allow_public_access_network_policy = var.allow_opensearch_public_access
  
  # Tags
  collection_tags = [
    for key, value in local.tags : {
      key   = key
      value = value
    }
  ]
}

# CloudWatch Log Group for monitoring (if logging is enabled)
resource "aws_cloudwatch_log_group" "knowledge_base_monitoring" {
  count = var.enable_logging ? 1 : 0
  
  name              = "/aws/bedrock/knowledge-base/${local.name_prefix}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.enable_cloudwatch_kms_encryption ? var.kms_key_id : null
  
  tags = local.tags
}


