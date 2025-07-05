output "knowledge_base_id" {
  description = "The ID of the created knowledge base"
  value       = module.bedrock_knowledge_base.knowledge_base_id
}

output "knowledge_base_arn" {
  description = "The ARN of the created knowledge base"
  value       = module.bedrock_knowledge_base.knowledge_base_arn
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for storing documents"
  value       = module.bedrock_knowledge_base.s3_bucket_name
}

output "opensearch_collection_endpoint" {
  description = "OpenSearch Serverless collection endpoint"
  value       = module.bedrock_knowledge_base.opensearch_collection_endpoint
}
