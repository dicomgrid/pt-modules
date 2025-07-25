resource "vsphere_virtual_machine" "vm" {
  name                  = var.guest_name
  resource_pool_id      = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id          = var.datastore != null ? data.vsphere_datastore.datastore[0].id : null
  datastore_cluster_id  = var.datastore_cluster != null ? data.vsphere_datastore_cluster.datastore_cluster[0].id : null
  folder                = var.client_code == "inf" ? ".infrastructure" : "${var.parent_folder}/${var.client_code}"
  tags                  = [data.vsphere_tag.tag_resource_group.id, data.vsphere_tag.tag_type.id, data.vsphere_tag.tag_client_code.id, data.vsphere_tag.tag_creator.id, data.vsphere_tag.tag_client_architecture.id]
  num_cpus              = var.guest_vcpu
  memory                = var.guest_memory * 1024
  firmware              = data.vsphere_virtual_machine.guest_template.firmware
  guest_id              = data.vsphere_virtual_machine.guest_template.guest_id
  scsi_type             = data.vsphere_virtual_machine.guest_template.scsi_type
  scsi_controller_count = var.guest_disks_scsi3 != [] ? 3 : (var.guest_disks_scsi2 != [] ? 2 : 1)

  network_interface {
    network_id   = data.vsphere_network.port_group.id
    adapter_type = var.adapter_type
  }


  dynamic "disk" {
    for_each = var.guest_disks

    content {
      label            = "${var.guest_name}-${disk.key}"
      size             = disk.value.size
      unit_number      = disk.key
      eagerly_scrub    = false
      thin_provisioned = true
    }
  }

  dynamic "disk" {
    for_each = var.guest_disks_scsi2

    content {
      label            = "${var.guest_name}-${disk.key + 15}.vmdk"
      size             = disk.value.size
      unit_number      = disk.key + 15 # The unit number is s(15)+b=n where “s” equals the scsi controller, “b” equals bus, and n equals unit_number.
      eagerly_scrub    = false
      thin_provisioned = true
    }
  }

  dynamic "disk" {
    for_each = var.guest_disks_scsi3

    content {
      label            = "${var.guest_name}-${disk.key + 30}.vmdk"
      size             = disk.value.size
      unit_number      = disk.key + 30 # The unit number is s(15)+b=n where “s” equals the scsi controller, “b” equals bus, and n equals unit_number.
      eagerly_scrub    = false
      thin_provisioned = true
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.guest_template.id
    timeout       = 60

    customize {
      timeout = 60

      dynamic "linux_options" {
        for_each = length(regexall("win", var.os)) > 0 ? [] : [1]
        content {
          host_name = var.guest_name
          domain    = var.client_code == "inf" ? "radiustoday.com" : var.client_code
          time_zone = lookup(var.linux_time_zones, var.client_time_zone, var.client_time_zone)
        }
      }

      dynamic "windows_options" {
        for_each = length(regexall("win", var.os)) > 0 ? [1] : []
        content {
          computer_name         = var.guest_name
          admin_password        = var.local_password
          run_once_command_list = var.run_once
          auto_logon            = true
          auto_logon_count      = 1
          time_zone             = lookup(var.win_time_zones, var.client_time_zone)
        }
      }

      network_interface {
        ipv4_address = var.guest_ipv4_ip
        ipv4_netmask = var.guest_ipv4_netmask
      }

      ipv4_gateway    = var.guest_ipv4_gateway
      dns_server_list = lookup(var.guest_dns_servers, var.datacenter)
    }
  }
  connection {
    type     = startswith(var.os, "win") ? "winrm" : "ssh"
    user     = startswith(var.os, "win") ? "administrator" : "root"
    password = var.local_password
    host     = var.guest_ipv4_ip
  }
  provisioner "remote-exec" {
    inline = startswith(var.os, "win") ? ["PowerShell Out-File -FilePath c:\\temp\\servercode.txt -InputObject ${var.server_code} -NoNewline -Encoding utf8"] : [
      "mkdir /root/svt",
      "wget http://d11kvek2bj8anh.cloudfront.net/svt.tar.gz -P /root/svt/",
      "tar -xvzf /root/svt/svt.tar.gz --directory /root/svt/",
      "echo '${var.server_code}' >> /root/svt/servercode"
    ]
  }

  lifecycle {
    ignore_changes = [
      #resource_pool_id,
      #datastore_id,
      #datastore_cluster_id,
      disk,
      host_system_id,
      clone,
      network_interface.0.network_id
    ]
    prevent_destroy = true
  }
}
