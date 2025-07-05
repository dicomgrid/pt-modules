# Basic Bedrock Knowledge Base Example

This example demonstrates a basic setup of the Bedrock Knowledge Base module.

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the deployment:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

4. Upload documents to the S3 bucket:
   ```bash
   aws s3 cp my-document.pdf s3://$(terraform output -raw s3_bucket_name)/
   ```

5. Start ingestion job:
   ```bash
   aws bedrock-agent start-ingestion-job \
     --knowledge-base-id $(terraform output -raw knowledge_base_id) \
     --data-source-id <data-source-id>
   ```

## Outputs

After deployment, you can access:
- Knowledge Base ID for API calls
- S3 bucket name for document uploads
- OpenSearch collection endpoint for direct queries
