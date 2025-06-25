variable "amis_to_copy" {
  description = "A list of AMIs and their details to be copied"
  type = list(object({
    source_ami_id          = string
    source_ami_region      = string
    target_ami_name        = string
    target_ami_description = string
    target_region          = string
    encrypted              = bool
    kms_key_id             = string
    tags                   = map(string)
  }))
}