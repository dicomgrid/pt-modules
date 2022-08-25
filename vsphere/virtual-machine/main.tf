#### VM CREATION ####

# Create VM
resource "vsphere_virtual_machine" "mso_virtual_machine" {
  name                      = var.server_name
  num_cpus                  = var.server_cpu
  memory                    = var.server_memory * 1024
  datastore_id              = data.vsphere_datastore.datastore.id
# datastore_cluster_id      = data.vsphere_datastore_cluster.datastore.id
  resource_pool_id          = data.vsphere_resource_pool.pool.id
  guest_id                  = data.vsphere_virtual_machine.template.guest_id
  scsi_type                 = data.vsphere_virtual_machine.template.scsi_type
  scsi_controller_count     = 3
  # Set network parameters
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # Use a predefined vmware template has main disk
  dynamic "disk" {
    for_each = var.server_disks

    content {
        label = "${var.server_name}-${disk.key}.vmdk"
        size = disk.value.size
        unit_number = disk.key      # The unit number is s(15)+b=n where “s” equals the scsi controller, “b” equals bus, and n equals unit_number. 
        eagerly_scrub = false
        thin_provisioned = true
      }
    }
  # Add any additional disks. These will not be included in vm snapshots.
  dynamic "disk" {
    for_each = range(var.server_disks_additional_count)

    content {
        label = "${var.server_name}-${disk.key + 15}.vmdk"
        size = var.server_disks_additional_size * 1024      # Default is in GB, using 1024 multiplier to convert to TB.
        unit_number = disk.key + 15                         # The unit number is s(15)+b=n where “s” equals the scsi controller, “b” equals bus, and n equals unit_number.
        eagerly_scrub = false
        thin_provisioned = true
      }
    }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    timeout = 60

    customize {
      timeout = 60
      dynamic "linux_options" {
        for_each = var.os == "linux" ? [1] : []
        content {
          host_name = var.server_name
          domain    = var.client_code
          time_zone = var.linux_time_zone
        }
      }
      dynamic "windows_options" {
        for_each = var.os == "windows" ? [1] : []
        content {
          computer_name         = var.server_name
          admin_password        = var.win_local_adminpass
          join_domain           = var.win_domain
          domain_admin_user     = var.domain_admin_user
          domain_admin_password = var.domain_admin_pw
          run_once_command_list = var.run_once
          auto_logon            = true
          auto_logon_count      = 1
          time_zone             = var.win_time_zone
        }
      }
      network_interface {
        ipv4_address    = var.server_ip
        ipv4_netmask    = var.server_netmask
        dns_server_list = var.server_dns
      }

      ipv4_gateway = var.server_gateway
      dns_server_list = var.server_dns
    }
  }
}