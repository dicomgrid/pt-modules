variable "ami" { default = "rocky_8_custom" }
variable "associate_public_ip_address" { default = "false" }
variable "default_tags" {}
variable "ebs_block_devices" {}
variable "ebs_block_devices_extra" { default = null }
variable "enable_metadata_options" { default = true }
variable "iam_instance_profile" { default = "" }
variable "instance_type" { default = "t2.micro" }
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
    c6a_xlarge              = "c6a.xlarge"
    m5_4xlarge              = "m5.4xlarge"
    r5_xlarge               = "r5.xlarge"
    r5_8xlarge_accelerator  = "r5.8xlarge"
    t3_large                = "t3.large"
    m5_2xlarge              = "m5.2xlarge"
    m6a_2xlarge             = "m6a.2xlarge"
  }
}
variable "key_name" { default = "ansible-rsa" }
variable "local_password" { default = null }
variable "private_ip" { default = null }
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
variable "security_groups" { default = [] }
variable "server_code" { default = null }
variable "server_name" {}
variable "subnet" {}
variable "user_data" { default = null }
