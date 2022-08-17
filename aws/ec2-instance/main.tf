resource "aws_instance" "main" {
  ami = lookup({
    centos_7                     = data.aws_ami.centos_7.id
    ubuntu_22_04                 = data.aws_ami.ubuntu_22_04.id
    rhel_8                       = data.aws_ami.rhel_8.id
    windows_server_2019          = data.aws_ami.windows_server_2019.id
    windows_server_2016_sql_2017 = data.aws_ami.windows_server_2016_sql_2017.id
  }, var.ami, var.ami)
  iam_instance_profile   = var.iam_instance_profile
  instance_type          = lookup(var.instance_types, var.instance_type, var.instance_type)
  key_name               = var.key_name
  private_ip             = var.private_ip
  subnet_id              = data.aws_subnet.main.id
  vpc_security_group_ids = data.aws_security_groups.main.ids

  dynamic "ebs_block_device" {
    for_each = lookup(element(var.ebs_block_device, 0), "delete_on_termination") != null ? var.ebs_block_device : []
    content {
      delete_on_termination = ebs_block_device.value["delete_on_termination"]
      device_name           = ebs_block_device.value["device_name"]
      encrypted             = ebs_block_device.value["encrypted"]
      volume_size           = ebs_block_device.value["volume_size"]
      volume_type           = ebs_block_device.value["volume_type"]
    }
  }

  dynamic "root_block_device" {
    for_each = lookup(element(var.root_block_device, 0), "delete_on_termination") != null ? var.root_block_device : []
    content {
      delete_on_termination = root_block_device.value["delete_on_termination"]
      encrypted             = root_block_device.value["encrypted"]
      volume_size           = root_block_device.value["volume_size"]
      volume_type           = root_block_device.value["volume_type"]
    }
  }

  tags = {
    Application = var.application
    Backups     = var.backups
    Billing     = var.billing
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }

  lifecycle {
    ignore_changes = [ami]
  }

  user_data = var.user_data
}