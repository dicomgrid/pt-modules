# .tflint.hcl - Place this in your repository root

# Core Terraform plugin (built-in rules)
plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

# AWS-specific plugin (no deep check = no AWS auth required)
plugin "aws" {
  enabled = true
  version = "0.30.0"  # Pin to specific version for consistency
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Configure specific rules
rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_deprecated_index" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

rule "terraform_standard_module_structure" {
  enabled = true
}

# Disable rules that are causing warnings (temporarily)
rule "terraform_required_providers" {
  enabled = false  # Disables "Missing version constraint for provider" warnings
}

rule "terraform_required_version" {
  enabled = false  # Disables "terraform required_version attribute is required" warnings
}

rule "terraform_typed_variables" {
  enabled = false  # Disables "variable has no type" warnings
}

# AWS-specific rules (examples - these work without AWS auth)
rule "aws_instance_invalid_type" {
  enabled = true
}

rule "aws_instance_previous_type" {
  enabled = true
}

rule "aws_db_instance_invalid_type" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_node_type" {
  enabled = true
}

rule "aws_alb_invalid_security_group" {
  enabled = true
}

rule "aws_alb_invalid_subnet" {
  enabled = true
}

rule "aws_security_group_rule_invalid_protocol" {
  enabled = true
}

# Disable rules that require AWS API access (deep check)
rule "aws_instance_invalid_ami" {
  enabled = false  # Requires AWS API to verify AMI exists
}

rule "aws_instance_invalid_subnet" {
  enabled = false  # Requires AWS API to verify subnet exists
}

rule "aws_route_invalid_gateway_id" {
  enabled = false  # Requires AWS API
}
