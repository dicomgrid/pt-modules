# Knowledge Base Outputs
output "knowledge_base_id" {
  description = "The ID of the created knowledge base"
  value       = module.bedrock_knowledge_base.default_kb_identifier
}

output "knowledge_base_arn" {
  description = "The ARN of the created knowledge base"
  value       = "arn:aws:bedrock:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:knowledge-base/${module.bedrock_knowledge_base.default_kb_identifier}"
}

output "knowledge_base_name" {
  description = "The name of the created knowledge base"
  value       = "${local.name_prefix}-knowledge-base"
}

# S3 Bucket Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket for storing documents"
  value       = aws_s3_bucket.knowledge_base_documents.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for storing documents"
  value       = aws_s3_bucket.knowledge_base_documents.arn
}

output "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.knowledge_base_documents.bucket_domain_name
}

# OpenSearch Serverless Outputs
output "opensearch_collection_name" {
  description = "Name of the OpenSearch Serverless collection"
  value       = module.opensearch_serverless.opensearch_serverless_collection.name
}

output "opensearch_collection_endpoint" {
  description = "OpenSearch Serverless collection endpoint"
  value       = module.opensearch_serverless.opensearch_serverless_collection.collection_endpoint
}

output "opensearch_collection_arn" {
  description = "OpenSearch Serverless collection ARN"
  value       = module.opensearch_serverless.opensearch_serverless_collection.arn
}

output "opensearch_dashboard_endpoint" {
  description = "OpenSearch dashboard endpoint"
  value       = module.opensearch_serverless.opensearch_serverless_collection.dashboard_endpoint
}

# Agent Outputs (conditional)
output "agent_id" {
  description = "The ID of the Bedrock agent (if created)"
  value       = var.create_agent ? module.bedrock_knowledge_base.bedrock_agent.agent_id : null
}

output "agent_arn" {
  description = "The ARN of the Bedrock agent (if created)"
  value       = var.create_agent ? module.bedrock_knowledge_base.bedrock_agent.agent_arn : null
}

output "agent_name" {
  description = "The name of the Bedrock agent (if created)"
  value       = var.create_agent ? module.bedrock_knowledge_base.bedrock_agent.agent_name : null
}

# Logging Outputs
output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group (if logging is enabled)"
  value       = var.enable_logging ? aws_cloudwatch_log_group.knowledge_base_monitoring[0].name : null
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group (if logging is enabled)"
  value       = var.enable_logging ? aws_cloudwatch_log_group.knowledge_base_monitoring[0].arn : null
}

# Additional Metadata
output "name_prefix" {
  description = "The name prefix used for resources"
  value       = local.name_prefix
}

output "aws_region" {
  description = "AWS region where resources are created"
  value       = data.aws_region.current.name
}

output "aws_account_id" {
  description = "AWS account ID where resources are created"
  value       = data.aws_caller_identity.current.account_id
}

output "tags" {
  description = "Tags applied to resources"
  value       = local.tags
}
