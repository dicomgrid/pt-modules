# Basic Configuration
variable "name_prefix" {
  description = "Prefix for naming resources. If not provided, a random suffix will be generated."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

# Agent Configuration
variable "create_agent" {
  description = "Whether to create a Bedrock agent alongside the knowledge base"
  type        = bool
  default     = false
}

variable "foundation_model" {
  description = "The foundation model to use for the agent"
  type        = string
  default     = "anthropic.claude-3-sonnet-20240229-v1:0"
  
  validation {
    condition = contains([
      "anthropic.claude-3-sonnet-20240229-v1:0",
      "anthropic.claude-3-haiku-20240307-v1:0",
      "anthropic.claude-v2:1",
      "anthropic.claude-instant-v1",
      "amazon.titan-text-premier-v1:0",
      "amazon.titan-text-express-v1"
    ], var.foundation_model)
    error_message = "Foundation model must be a supported Bedrock model."
  }
}

variable "agent_instruction" {
  description = "Instructions for the Bedrock agent"
  type        = string
  default     = "You are a helpful AI assistant that can answer questions based on the knowledge base documents."
}

# Knowledge Base Configuration
variable "kb_description" {
  description = "Description of the knowledge base"
  type        = string
  default     = "Knowledge base for document search and retrieval"
}

variable "embedding_model_arn" {
  description = "ARN of the embedding model to use for the knowledge base"
  type        = string
  default     = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v1"
}

variable "vector_dimension" {
  description = "Dimension of the vector embeddings"
  type        = number
  default     = 1536
  
  validation {
    condition     = var.vector_dimension > 0 && var.vector_dimension <= 4096
    error_message = "Vector dimension must be between 1 and 4096."
  }
}

variable "embedding_model_dimensions" {
  description = "Dimensions for the embedding model"
  type        = number
  default     = 1536
}

variable "embedding_data_type" {
  description = "Data type for embeddings"
  type        = string
  default     = "FLOAT32"
  
  validation {
    condition     = contains(["FLOAT32", "BINARY"], var.embedding_data_type)
    error_message = "Embedding data type must be either FLOAT32 or BINARY."
  }
}

# Data Source Configuration
variable "data_deletion_policy" {
  description = "Data deletion policy for the knowledge base"
  type        = string
  default     = "RETAIN"
  
  validation {
    condition     = contains(["DELETE", "RETAIN"], var.data_deletion_policy)
    error_message = "Data deletion policy must be either DELETE or RETAIN."
  }
}

variable "s3_inclusion_prefixes" {
  description = "List of S3 prefixes to include in the data source"
  type        = list(string)
  default     = [""]
}

# Chunking Strategy Configuration
variable "chunking_strategy" {
  description = "Chunking strategy for processing documents"
  type        = string
  default     = "FIXED_SIZE"
  
  validation {
    condition     = contains(["FIXED_SIZE", "NONE"], var.chunking_strategy)
    error_message = "Chunking strategy must be either FIXED_SIZE or NONE."
  }
}

variable "chunking_strategy_max_tokens" {
  description = "Maximum number of tokens per chunk"
  type        = number
  default     = 300
  
  validation {
    condition     = var.chunking_strategy_max_tokens >= 1 && var.chunking_strategy_max_tokens <= 8192
    error_message = "Max tokens per chunk must be between 1 and 8192."
  }
}

variable "chunking_strategy_overlap_percentage" {
  description = "Percentage of overlap between chunks"
  type        = number
  default     = 20
  
  validation {
    condition     = var.chunking_strategy_overlap_percentage >= 1 && var.chunking_strategy_overlap_percentage <= 99
    error_message = "Overlap percentage must be between 1 and 99."
  }
}

# Vector Ingestion Configuration
variable "enable_vector_ingestion_configuration" {
  description = "Whether to enable vector ingestion configuration"
  type        = bool
  default     = true
}

variable "enable_parsing_configuration" {
  description = "Whether to enable parsing configuration"
  type        = bool
  default     = true
}

variable "parsing_strategy" {
  description = "Strategy for parsing documents"
  type        = string
  default     = "BEDROCK_FOUNDATION_MODEL"
  
  validation {
    condition     = contains(["BEDROCK_FOUNDATION_MODEL"], var.parsing_strategy)
    error_message = "Parsing strategy must be BEDROCK_FOUNDATION_MODEL."
  }
}

# OpenSearch Configuration
variable "allow_opensearch_public_access" {
  description = "Whether to allow public access to OpenSearch"
  type        = bool
  default     = false
}

variable "number_of_shards" {
  description = "Number of shards for the OpenSearch index"
  type        = number
  default     = 1
  
  validation {
    condition     = var.number_of_shards >= 1 && var.number_of_shards <= 10
    error_message = "Number of shards must be between 1 and 10."
  }
}

variable "number_of_replicas" {
  description = "Number of replicas for the OpenSearch index"
  type        = number
  default     = 0
  
  validation {
    condition     = var.number_of_replicas >= 0 && var.number_of_replicas <= 5
    error_message = "Number of replicas must be between 0 and 5."
  }
}

variable "create_vector_index" {
  description = "Whether to create a vector index in OpenSearch"
  type        = bool
  default     = true
}

variable "index_knn_algo_param_ef_search" {
  description = "KNN algorithm parameter for ef_search"
  type        = number
  default     = 512
  
  validation {
    condition     = var.index_knn_algo_param_ef_search >= 100 && var.index_knn_algo_param_ef_search <= 10000
    error_message = "ef_search parameter must be between 100 and 10000."
  }
}

variable "custom_vector_mappings" {
  description = "Custom vector mappings for the OpenSearch index (JSON string). If null, default Bedrock-compatible mappings will be used."
  type        = string
  default     = null
}

# Logging Configuration
variable "enable_logging" {
  description = "Whether to enable CloudWatch logging for the knowledge base"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 14
  
  validation {
    condition = contains([
      1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653
    ], var.log_retention_days)
    error_message = "Log retention days must be one of the valid CloudWatch log retention periods."
  }
}

# KMS Encryption Configuration
variable "kms_key_id" {
  description = "KMS key ID for encrypting S3 bucket and CloudWatch logs. If not provided, AWS managed keys will be used."
  type        = string
  default     = null
}

variable "enable_s3_kms_encryption" {
  description = "Whether to use KMS encryption for S3 bucket instead of AES256"
  type        = bool
  default     = false
}

variable "enable_cloudwatch_kms_encryption" {
  description = "Whether to use KMS encryption for CloudWatch log group"
  type        = bool
  default     = false
}

# S3 Security Configuration
variable "enable_s3_access_logging" {
  description = "Whether to enable S3 access logging"
  type        = bool
  default     = false
}

variable "s3_access_log_bucket" {
  description = "S3 bucket for access logs. Required if enable_s3_access_logging is true."
  type        = string
  default     = null
}

variable "s3_access_log_prefix" {
  description = "Prefix for S3 access logs"
  type        = string
  default     = "access-logs/"
}

variable "enable_s3_lifecycle_policy" {
  description = "Whether to enable S3 lifecycle policy for cost optimization"
  type        = bool
  default     = false
}

variable "s3_lifecycle_transition_days" {
  description = "Number of days after which to transition objects to IA storage class"
  type        = number
  default     = 30
}

variable "s3_lifecycle_expiration_days" {
  description = "Number of days after which to expire objects. Set to 0 to disable expiration."
  type        = number
  default     = 0
}
