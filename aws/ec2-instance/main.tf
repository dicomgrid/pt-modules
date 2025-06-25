resource "aws_instance" "main" {
  ami = lookup({
    centos7             = data.aws_ami.centos7.id
    amazon_linux_2      = data.aws_ami.amazon_linux_2.id
    ubuntu_22_04        = data.aws_ami.ubuntu_22_04.id
    rhel_8              = data.aws_ami.rhel_8.id
    rocky_8             = data.aws_ami.rocky_8.id
    rocky_9             = data.aws_ami.rocky_9.id
    rocky_8_custom      = data.aws_ami.rocky_8_custom.id
    windows_2019_custom = data.aws_ami.windows_2019_custom.id
    windows_server_2019 = data.aws_ami.windows_server_2019.id
    # windows_2022_custom          = data.aws_ami.windows_2022_custom.id
    windows_server_2016_sql_2017 = data.aws_ami.windows_server_2016_sql_2017.id
  }, var.ami, var.ami)
  iam_instance_profile        = var.iam_instance_profile
  instance_type               = lookup(var.instance_types, var.instance_type, var.instance_type)
  key_name                    = var.key_name
  private_ip                  = var.private_ip
  associate_public_ip_address = var.associate_public_ip_address
  subnet_id                   = data.aws_subnet.main.id
  vpc_security_group_ids      = data.aws_security_groups.main.ids
  tags                        = merge(var.default_tags, { "Name" = "${var.server_name}" })
  user_data                   = var.user_data

  root_block_device {
    delete_on_termination = lookup(var.root_block_device[0], "delete_on_termination", false)
    encrypted             = lookup(var.root_block_device[0], "encrypted", true)
    volume_size           = var.root_block_device[0]["volume_size"]
    volume_type           = var.root_block_device[0]["volume_type"]
    iops                  = lookup(var.root_block_device[0], "iops", null)
    throughput            = lookup(var.root_block_device[0], "throughput", null)
    tags                  = merge(var.default_tags, { "Name" = "${var.server_name}-0" })
  }
####
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_devices != null ? var.ebs_block_devices : null
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", false)
      device_name           = ebs_block_device.value["device_name"]
      encrypted             = lookup(ebs_block_device.value, "encrypted", true)
      volume_size           = ebs_block_device.value["volume_size"]
      volume_type           = ebs_block_device.value["volume_type"]
      iops                  = lookup(ebs_block_device.value, "iops", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      tags                  = merge(var.default_tags, { "Name" = "${var.server_name}-${ebs_block_device.key}" })
    }
  }

  metadata_options {
    http_tokens = "required"
  }

  # connection {
  #   type     = startswith(var.ami, "win") ? "winrm" : "ssh"
  #   user     = startswith(var.ami, "win") ? "administrator" : "root"
  #   password = var.local_password
  #   host     = self.private_ip
  #   timeout  = "10m"
  # }

  # provisioner "remote-exec" {
  #   inline = startswith(var.ami, "win") ? ["PowerShell Out-File -FilePath c:\\temp\\servercode.txt -InputObject ${var.server_code} -NoNewline -Encoding utf8"] : [
  #     "mkdir /root/svt",
  #     "wget http://d11kvek2bj8anh.cloudfront.net/svt.tar.gz -P /root/svt/",
  #     "tar -xvzf /root/svt/svt.tar.gz --directory /root/svt/",
  #     "echo '${var.server_code}' >> /root/svt/servercode"
  #   ]
  # }

  lifecycle {
    ignore_changes  = [ami, associate_public_ip_address, key_name, user_data, ebs_block_device]
    prevent_destroy = true
  }
}

###for additions after creation
resource "aws_ebs_volume" "main" {
  for_each = var.ebs_block_devices_extra != null ? var.ebs_block_devices_extra : {}

  availability_zone = aws_instance.main.availability_zone
  size              = each.value["volume_size"]
  encrypted         = lookup(each.value, "encrypted", true)
  kms_key_id        = lookup(each.value, "kms_key_id", null)
  snapshot_id       = lookup(each.value, "snapshot_id", null)
  type              = each.value["volume_type"]
  iops              = lookup(each.value, "iops", null)
  throughput        = lookup(each.value, "throughput", null)

  tags = merge(var.default_tags, { "Name" = "${var.server_name}-${each.key}" })

  lifecycle {
    prevent_destroy = true
  }
}

###for additions after creation
resource "aws_volume_attachment" "main" {
  for_each = var.ebs_block_devices_extra != null ? var.ebs_block_devices_extra : {}

  device_name = each.value["device_name"]
  volume_id   = aws_ebs_volume.main[each.key].id
  instance_id = aws_instance.main.id

  lifecycle {
    prevent_destroy = true
  }
}
