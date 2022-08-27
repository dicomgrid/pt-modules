variable "ami" {
  default = "centos_7"
}

variable "application" {
  default = ""
}

variable "backups" {
  default = ""
}

variable "billing" {
  default = ""
}

variable "creator" {
  default = "Terraform"
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

variable "environment" {}

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
  default = "aws"
}

variable "name" {}

variable "owner" {
  default = "Platform"
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
