# AWS Bedrock Knowledge Base Terraform Module

This Terraform module creates a comprehensive AWS-native knowledge base infrastructure using Amazon Bedrock Knowledge Base, OpenSearch Serverless, and S3. It's designed for Retrieval-Augmented Generation (RAG) applications and provides a robust foundation for generative AI and search applications.

## Features

- **Amazon Bedrock Knowledge Base** - Fully managed RAG service
- **OpenSearch Serverless** - Vector storage with automatic scaling
- **S3 Document Storage** - Secure, versioned document storage
- **IAM Security** - Proper roles and policies following AWS best practices
- **CloudWatch Logging** - Comprehensive monitoring and logging
- **Optional Bedrock Agent** - AI agent with knowledge base integration
- **Customizable Vector Configuration** - Flexible embedding and chunking strategies

## Architecture

```text
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   S3 Bucket     │    │  Bedrock KB     │    │  OpenSearch     │
│   (Documents)   │───▶│  (RAG Engine)   │───▶│  Serverless     │
│                 │    │                 │    │  (Vector Store) │
└─────────────────┘    └─────────────────┘    └─────────────────┘
        │                       │                       │
        │                       │                       │
        ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   IAM Roles     │    │  CloudWatch     │    │  Bedrock Agent  │
│   & Policies    │    │  Logs           │    │  (Optional)     │
│                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Usage

### Basic Usage

```hcl
module "knowledge_base" {
  source = "./aws/bedrock-knowledge-base"

  name_prefix = "my-kb"
  
  tags = {
    Environment = "production"
    Project     = "ai-assistant"
  }
}
```

### Advanced Usage with Agent

```hcl
module "knowledge_base" {
  source = "./aws/bedrock-knowledge-base"

  name_prefix = "advanced-kb"
  
  # Agent Configuration
  create_agent = true
  foundation_model = "anthropic.claude-3-sonnet-20240229-v1:0"
  agent_instruction = "You are a specialized AI assistant for technical documentation."
  
  # Knowledge Base Configuration
  kb_description = "Technical documentation knowledge base"
  embedding_model_arn = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v1"
  vector_dimension = 1536
  
  # Chunking Strategy
  chunking_strategy = "FIXED_SIZE"
  chunking_strategy_max_tokens = 500
  chunking_strategy_overlap_percentage = 20
  
  # Security
  allow_opensearch_public_access = false
  
  # Logging
  enable_logging = true
  log_retention_days = 30
  
  tags = {
    Environment = "production"
    Project     = "ai-assistant"
    Team        = "ai-ml"
  }
}
```

### Custom Vector Configuration

```hcl
module "knowledge_base" {
  source = "./aws/bedrock-knowledge-base"

  name_prefix = "custom-vectors-kb"
  
  # Custom vector settings
  vector_dimension = 1024
  embedding_model_dimensions = 1024
  number_of_shards = 2
  number_of_replicas = 1
  
  # Custom OpenSearch mappings
  custom_vector_mappings = jsonencode({
    "properties": {
      "custom-vector-field": {
        "type": "knn_vector",
        "dimension": 1024,
        "method": {
          "name": "hnsw",
          "space_type": "cosinesimil",
          "engine": "nmslib"
        }
      }
    }
  })
  
  tags = {
    Environment = "development"
    UseCase     = "custom-embeddings"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |
| awscc | >= 1.0.0 |
| opensearch | ~> 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.0 |
| awscc | >= 1.0.0 |
| opensearch | ~> 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| bedrock_knowledge_base | aws-ia/bedrock/aws | ~> 0.0.28 |
| opensearch_serverless | aws-ia/opensearch-serverless/aws | ~> 0.0.4 |

## Resources

| Name | Type |
|------|------|
| aws_s3_bucket.knowledge_base_documents | resource |
| aws_s3_bucket_versioning.knowledge_base_documents | resource |
| aws_s3_bucket_server_side_encryption_configuration.knowledge_base_documents | resource |
| aws_s3_bucket_public_access_block.knowledge_base_documents | resource |
| aws_cloudwatch_log_group.knowledge_base_monitoring | resource |
| random_string.suffix | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name_prefix | Prefix for naming resources. If not provided, a random suffix will be generated. | `string` | `null` | no |
| tags | A map of tags to assign to all resources | `map(string)` | `{}` | no |
| create_agent | Whether to create a Bedrock agent alongside the knowledge base | `bool` | `false` | no |
| foundation_model | The foundation model to use for the agent | `string` | `"anthropic.claude-3-sonnet-20240229-v1:0"` | no |
| agent_instruction | Instructions for the Bedrock agent | `string` | `"You are a helpful AI assistant that can answer questions based on the knowledge base documents."` | no |
| kb_description | Description of the knowledge base | `string` | `"Knowledge base for document search and retrieval"` | no |
| embedding_model_arn | ARN of the embedding model to use for the knowledge base | `string` | `"arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v1"` | no |
| vector_dimension | Dimension of the vector embeddings | `number` | `1536` | no |
| embedding_model_dimensions | Dimensions for the embedding model | `number` | `1536` | no |
| embedding_data_type | Data type for embeddings | `string` | `"FLOAT32"` | no |
| data_deletion_policy | Data deletion policy for the knowledge base | `string` | `"RETAIN"` | no |
| s3_inclusion_prefixes | List of S3 prefixes to include in the data source | `list(string)` | `[""]` | no |
| chunking_strategy | Chunking strategy for processing documents | `string` | `"FIXED_SIZE"` | no |
| chunking_strategy_max_tokens | Maximum number of tokens per chunk | `number` | `300` | no |
| chunking_strategy_overlap_percentage | Percentage of overlap between chunks | `number` | `20` | no |
| enable_vector_ingestion_configuration | Whether to enable vector ingestion configuration | `bool` | `true` | no |
| enable_parsing_configuration | Whether to enable parsing configuration | `bool` | `true` | no |
| parsing_strategy | Strategy for parsing documents | `string` | `"BEDROCK_FOUNDATION_MODEL"` | no |
| allow_opensearch_public_access | Whether to allow public access to OpenSearch | `bool` | `false` | no |
| number_of_shards | Number of shards for the OpenSearch index | `number` | `1` | no |
| number_of_replicas | Number of replicas for the OpenSearch index | `number` | `0` | no |
| create_vector_index | Whether to create a vector index in OpenSearch | `bool` | `true` | no |
| index_knn_algo_param_ef_search | KNN algorithm parameter for ef_search | `number` | `512` | no |
| custom_vector_mappings | Custom vector mappings for the OpenSearch index (JSON string). If null, default Bedrock-compatible mappings will be used. | `string` | `null` | no |
| enable_logging | Whether to enable CloudWatch logging for the knowledge base | `bool` | `true` | no |
| log_retention_days | Number of days to retain CloudWatch logs | `number` | `14` | no |

## Outputs

| Name | Description |
|------|-------------|
| knowledge_base_id | The ID of the created knowledge base |
| knowledge_base_arn | The ARN of the created knowledge base |
| knowledge_base_name | The name of the created knowledge base |
| s3_bucket_name | Name of the S3 bucket for storing documents |
| s3_bucket_arn | ARN of the S3 bucket for storing documents |
| s3_bucket_domain_name | Domain name of the S3 bucket |
| opensearch_collection_name | Name of the OpenSearch Serverless collection |
| opensearch_collection_endpoint | OpenSearch Serverless collection endpoint |
| opensearch_collection_arn | OpenSearch Serverless collection ARN |
| opensearch_dashboard_endpoint | OpenSearch dashboard endpoint |
| agent_id | The ID of the Bedrock agent (if created) |
| agent_arn | The ARN of the Bedrock agent (if created) |
| agent_name | The name of the Bedrock agent (if created) |
| cloudwatch_log_group_name | Name of the CloudWatch log group (if logging is enabled) |
| cloudwatch_log_group_arn | ARN of the CloudWatch log group (if logging is enabled) |
| name_prefix | The name prefix used for resources |
| aws_region | AWS region where resources are created |
| aws_account_id | AWS account ID where resources are created |
| tags | Tags applied to resources |

## Getting Started

### 1. Upload Documents to S3

After deploying the module, upload your documents to the S3 bucket:

```bash
aws s3 cp my-document.pdf s3://your-kb-bucket-name/
aws s3 cp documents/ s3://your-kb-bucket-name/ --recursive
```

### 2. Sync the Knowledge Base

Trigger a knowledge base sync to process your documents:

```bash
aws bedrock-agent start-ingestion-job \
  --knowledge-base-id <knowledge-base-id> \
  --data-source-id <data-source-id>
```

### 3. Query the Knowledge Base

Use the knowledge base for retrieval:

```python
import boto3

bedrock_agent = boto3.client('bedrock-agent-runtime')

response = bedrock_agent.retrieve(
    knowledgeBaseId='<knowledge-base-id>',
    retrievalQuery={
        'text': 'Your search query here'
    }
)
```

## Security Considerations

- **S3 Bucket**: Configured with versioning, encryption, and public access blocked
- **IAM Roles**: Minimal required permissions following principle of least privilege
- **OpenSearch**: Private by default, public access must be explicitly enabled
- **Encryption**: All data encrypted at rest and in transit

## Cost Optimization

- **OpenSearch Serverless**: Pay-per-use pricing with automatic scaling
- **S3**: Intelligent tiering can be added for cost optimization
- **CloudWatch Logs**: Configurable retention periods to manage costs
- **Bedrock**: Pay-per-token pricing for embedding and queries

## Troubleshooting

### Common Issues

1. **Module not found**: Ensure the AWS-IA modules are available in the Terraform registry
2. **Permission errors**: Check IAM roles and policies
3. **Regional availability**: Ensure Bedrock is available in your chosen region
4. **Vector dimension mismatch**: Ensure embedding model dimensions match vector configuration

### Debugging

Enable debug logging:

```hcl
enable_logging = true
log_retention_days = 7
```

Check CloudWatch logs for detailed error information.

## Examples

See the `examples/` directory for complete working examples:

- `examples/basic/` - Simple knowledge base setup
- `examples/advanced/` - Knowledge base with agent
- `examples/custom-vectors/` - Custom vector configuration

## Contributing

Please read the contributing guidelines and ensure all tests pass before submitting a pull request.

## License

This module is licensed under the MIT License. See LICENSE file for details.

## Support

For support, please open an issue in the GitHub repository or contact the maintainers.
