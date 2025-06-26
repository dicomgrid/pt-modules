resource "aws_ami_copy" "example" {
  for_each = { for ami in var.amis_to_copy : ami.source_ami_id => ami }

  source_ami_id     = each.value.source_ami_id
  source_ami_region = each.value.source_ami_region
  name              = each.value.target_ami_name
  description       = each.value.target_ami_description
  encrypted         = each.value.encrypted
  kms_key_id        = each.value.kms_key_id == "" ? null : each.value.kms_key_id

  tags = each.value.tags

  # Make sure to configure provider aliases if copying across regions.
}