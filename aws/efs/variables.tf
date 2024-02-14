variable "transition_to_ia" {
  default     = null
  description = "AFTER_30_DAYS, AFTER_60_DAYS, AFTER_90_DAYS"
}

variable "encrypted" {
  default = true
}

variable "kms_key_id" {
  default = null
}

variable "backup" {
  default = "ENABLED"
}

# -- Performance Settings ---
variable "performance_mode" {
  default     = "generalPurpose"
  description = "maxIO or generalPurpose"
}

variable "throughput_mode" {
  default     = "bursting"
  description = "bursting or provisioned"
}

variable "provisioned_throughput_in_mibps" {
  default = null
}

##tags
locals {
  tags = {
    Application              = var.application
    Backups                  = var.backups
    Billing                  = var.billing
    CodeManaged              = var.codemanaged
    Compliance               = var.compliance
    Environment              = var.environment
    Name                     = var.name
    OneTime                  = var.onetime
    Owner                    = var.owner
    Product                  = var.product
    aws-migration-project-id = var.aws_project_id
    map-migrated             = var.map_migrated
  }
}

variable "application" {
  default = ""
}
variable "backups" {
  default = null
}
variable "billing" {
  default = ""
}
variable "codemanaged" {
  default = "true"
}
variable "compliance" {
  default = "null"
}
variable "environment" {}
variable "name" {}
variable "onetime" {
  default = null
}
variable "owner" {
  default = "platform"
}
variable "product" {
  default = "ambra"
}
variable "aws_project_id" {
  default = null
}
variable "map_migrated" {
  default = null
}