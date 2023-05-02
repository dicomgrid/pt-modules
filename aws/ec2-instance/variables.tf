variable "ami" {
  default = "centos7"
}

variable "associate_public_ip_address" {
  default = "false"
}
variable "ebs_block_device" {
  default = [
    {
      delete_on_termination = null
      device_name           = null
      encrypted             = null
      volume_size           = null
      volume_type           = null
      iops                  = null
      throughput            = null
    }
  ]
}
variable "iam_instance_profile" {
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}


variable "instance_types" {
  default = {
    small_accelerator       = "c5.2xlarge"
    small_gateway           = "c5.2xlarge"
    small_privatecloud      = "c5.2xlarge"
    medium_accelerator      = "c5.4xlarge"
    medium_gateway          = "c5.9xlarge"
    fullstack_privatecloud  = "r5.4xlarge"
    powerscribe360          = "m4.xlarge"
    c5_12xlarge_accelerator = "c5.12xlarge"
    c5_xlarge               = "c5.xlarge"
    m5_4xlarge              = "m5.4xlarge"
    r5_xlarge               = "r5.xlarge"
    r5_8xlarge_accelerator  = "r5.8xlarge"
    t3_large                = "t3.large"
    m5_2xlarge              = "m5.2xlarge"
  }
}

variable "key_name" {
  default = "ims-deployer-rsa"
}

variable "cluster" {
  default = null
}

variable "private_ip" {
  default = null
}

variable "root_block_device" {
  default = [
    {
      delete_on_termination = null
      encrypted             = null
      volume_size           = null
      volume_type           = null
      iops                  = null
      throughput            = null
    }
  ]
}

variable "subnet" {}

variable "security_groups" {
  default = []
}

variable "user_data" {
  default = null
}



# Tags
locals {
  default_tags = {
    Backups                  = var.backups
    CodeManaged              = var.code_managed
    Compliance               = var.compliance
    OneTime                  = var.onetime
    aws-migration-project-id = var.aws_project_id
    map-migrated             = var.map_migrated
  }
  tags = merge(local.default_tags, var.tags)
}
variable "tags" {}

variable "aws_project_id" { default = "null" }
variable "backups" { default = "null" }
variable "code_managed" { default = "true" }
variable "compliance" { default = "null" }
variable "map_migrated" { default = "null" }
variable "onetime" { default = "null" }