variable "region" {
  description = "The AWS region to use for the Secrets Manager"
  type        = string
  default     = "us-east-2"
}

variable "secret_name" {
  description = "The name of the secret, including the path if necessary"
  type        = string
}

variable "description" {
  description = "The description of the secret"
  type        = string
  default     = ""
}

variable "secret_string" {
  description = "The secret string to store"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "policy" {
  description = "A valid AWS policy JSON document to attach to the secret"
  type        = string
  default     = ""
}