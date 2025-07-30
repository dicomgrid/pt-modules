module "foundation" {
  source              = "git::ssh://git@github.com/intelerad-org/plt-modules.git?ref=aws/infrastructure-context/v24.1.0"
  environment         = var.environment
  client_code         = var.client_code
  owner               = var.owner
  product             = var.product
  code_managed        = true
  creator             = ""
  compliance          = ""
  vpc_tags            = var.vpc_tags
  private_subnet_tags = var.private_subnet_tags
  public_subnet_tags  = var.public_subnet_tags
  additional_tags = merge(var.additional_tags, {
    Component = "gateway"
    Service   = "trustgrid"
  })
}

# Validation using the new validation structures
resource "null_resource" "validate_deployment" {
  lifecycle {
    precondition {
      condition     = local.deployment_ready
      error_message = join("\n", concat(
        ["Deployment validation failed:"],
        local.validation_errors
      ))
    }
  }
}

# Network interfaces using gateway_matrix
resource "aws_network_interface" "gateway_interfaces" {
  for_each = merge(
    {
      for idx, gw in local.gateway_matrix : 
      "${idx}-mgmt" => {
        gateway    = gw
        type       = "management"
        subnet_id  = gw.public_subnet_id
        security_groups = [module.management_security_group.id]
        private_ips = []
      }
    },
    {
      for idx, gw in local.gateway_matrix : 
      "${idx}-data" => {
        gateway    = gw
        type       = "data"
        subnet_id  = gw.private_subnet_id
        security_groups = [module.data_security_group.id]
        private_ips = [gw.data_ip]
      }
    }
  )
  
  subnet_id         = each.value.subnet_id
  security_groups   = each.value.security_groups
  source_dest_check = false
  private_ips       = length(each.value.private_ips) > 0 ? each.value.private_ips : null
  description       = "${each.value.type} interface for ${each.value.gateway.name}"
  
  tags = merge(module.foundation.tags, {
    Name             = "${each.value.gateway.name}-${each.value.type}-eni"
    Type             = each.value.type
    Role             = each.value.gateway.role
    AvailabilityZone = each.value.gateway.availability_zone
  })
}

# EC2 instances using gateway_matrix
resource "aws_instance" "trustgrid_gateways" {
  for_each = local.gateway_matrix
  
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  iam_instance_profile = local.resource_names.iam_profile
  
  network_interface {
    network_interface_id = aws_network_interface.gateway_interfaces["${each.key}-mgmt"].id
    device_index         = 0
  }
  
  network_interface {
    network_interface_id = aws_network_interface.gateway_interfaces["${each.key}-data"].id
    device_index         = 1
  }
  
  user_data_base64 = data.cloudinit_config.trustgrid_init[each.key].rendered
  
  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
  }
  
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "disabled"
  }
  
  tags = merge(module.foundation.tags, {
    Name             = each.value.name
    Type             = "trustgrid-gateway"
    Role             = each.value.role
    ClusterMember    = each.value.role
    ClusterActive    = each.value.cluster.is_active
    AvailabilityZone = each.value.availability_zone
  })
  
  depends_on = [
    module.trustgrid_iam,
    null_resource.validate_deployment
  ]
}

# EIPs using gateway_matrix
resource "aws_eip" "gateway_management" {
  for_each = local.gateway_matrix
  domain   = "vpc"
  
  tags = merge(module.foundation.tags, {
    Name = "${each.value.name}-mgmt-eip"
    Type = "management"
    Role = each.value.role
  })
  
  lifecycle {
    postcondition {
      condition     = self.allocation_id != "" && self.public_ip != ""
      error_message = "EIP allocation failed for ${each.value.name}. Check EIP quota limits."
    }
  }
}

resource "aws_eip_association" "gateway_management" {
  for_each = local.gateway_matrix
  
  allocation_id        = aws_eip.gateway_management[each.key].id
  network_interface_id = aws_network_interface.gateway_interfaces["${each.key}-mgmt"].id
}

# TrustGrid licenses
resource "tg_license" "gateway_licenses" {
  for_each = local.gateway_matrix
  name     = each.value.name
}

# Single sleep resource
resource "time_sleep" "wait_for_node_registration" {
  create_duration = var.node_registration_wait_time
  
  depends_on = [
    aws_instance.trustgrid_gateways,
    aws_eip_association.gateway_management
  ]
}



resource "tg_cluster" "gateway_cluster" {
  count = var.enable_trustgrid_cluster ? 1 : 0
  name  = "${var.client_code}awcl"
  
  depends_on = [time_sleep.wait_for_node_registration]
}

resource "tg_cluster_member" "gateway_members" {
  for_each = var.enable_trustgrid_cluster ? local.gateway_matrix : {}
  
  cluster_fqdn = tg_cluster.gateway_cluster[0].fqdn
  node_id      = data.tg_node.registered_gateways[each.key].id
  
  depends_on = [tg_cluster.gateway_cluster]
}


resource "tg_tagging" "node_tags" {
  for_each = local.gateway_matrix
  
  node_id = data.tg_node.registered_gateways[each.key].id
  
  tags = merge(
    module.foundation.tags,
    {
      client_code    = var.client_code
      is_gateway     = "true"
      cluster_member = each.value.role
      environment    = var.environment
      instance_type  = var.instance_type
      heartbeat_ip   = each.value.data_ip
      subnet_cidr    = each.value.private_subnet_cidr
      availability_zone = each.value.availability_zone
    }
  )
  
  depends_on = [tg_cluster_member.gateway_members]
}


resource "tg_tagging" "cluster_tags" {
  count = var.enable_trustgrid_cluster ? 1 : 0
  
  cluster_fqdn = tg_cluster.gateway_cluster[0].fqdn
  tags = merge(
    module.foundation.tags,
    {
      client_code = var.client_code
      is_gateway  = true
      cluster     = true
    }
  )
  
  depends_on = [tg_cluster.gateway_cluster]
}


resource "tg_node_cluster_config" "gateway_cluster_config" {
  for_each = local.gateway_matrix
  
  node_id = data.tg_node.registered_gateways[each.key].id
  
  host = each.value.data_ip
  port = var.trustgrid_cluster_port
  
  status_host = aws_eip.gateway_management[each.key].public_ip
  status_port = var.cluster_health_check_port
  
  enabled = true
  active  = each.value.cluster.is_active
  
  depends_on = [
    tg_cluster_member.gateway_members,
    aws_eip.gateway_management
  ]
}

# Gateway configuration
resource "tg_gateway_config" "gateway_config" {
  for_each = local.gateway_matrix
  
  node_id = data.tg_node.registered_gateways[each.key].id
  
  enabled               = true
  type                  = var.trustgrid_gateway_type
  host                  = aws_eip.gateway_management[each.key].public_ip
  port                  = var.trustgrid_gateway_port
  udp_enabled           = var.enable_udp
  udp_port              = var.trustgrid_gateway_port
  maxmbps               = var.gateway_max_throughput_mbps
  max_client_write_mbps = var.gateway_max_egress_mbps
  connect_to_public     = var.connect_to_public
  
  # Dynamic clients for private gateways
 dynamic "client" {
    for_each = var.trustgrid_gateway_type == "private" ? toset(concat(
      flatten([for group, nodes in data.tg_nodes.client_groups : [
        for fqdn in nodes.node_fqdns : split(".", fqdn)[0]  # Extract hostname only
      ]]),
      [for fqdn in var.additional_gateway_clients : split(".", fqdn)[0]]  # Extract hostname only
    )) : []
    
    content {
      name    = client.value
      enabled = true
    }
 
  }
  depends_on = [tg_node_cluster_config.gateway_cluster_config]
}


resource "tg_network_config" "gateway_network" {
  for_each = local.gateway_matrix
  
  node_id    = data.tg_node.registered_gateways[each.key].id
  forwarding = true
  
  interface {
    nic     = var.data_interface_name
    dhcp    = false
    ip      = "${each.value.data_ip}/${each.value.subnet_mask_bits}"
    gateway = each.value.gateway_ip
    
    cluster_route_tables = tolist(local.route_table_analysis.unique_tables)
    

dynamic "cloud_route" {
  for_each = each.value.cluster.manages_routes ? var.edge_route_cidrs : []
  content {
    route       = cloud_route.value
    description = "Network route managed by TrustGrid cluster"
  }
}
    
    # HA heartbeat routes
    route {
      route       = each.value.peer.subnet_cidr
      description = "HA heartbeat route to peer node subnet"
      next_hop    = each.value.gateway_ip
    }
    
    route {
      route       = "${each.value.peer.data_ip}/32"
      description = "HA heartbeat route to peer node IP"
      next_hop    = each.value.gateway_ip
    }
  }
  
  interface {
    nic  = var.management_interface_name
    dhcp = true
  }
  
  depends_on = [tg_gateway_config.gateway_config]
}
resource "aws_cloudwatch_log_group" "trustgrid" {
  for_each = var.enable_cloudwatch_logs ? local.gateway_matrix : {}
  
  name              = "/aws/ec2/trustgrid/${each.value.name}"
  retention_in_days = var.log_retention_days
  
  tags = module.foundation.tags
}

data "cloudinit_config" "trustgrid_init" {
  for_each = local.gateway_matrix
  
  gzip          = true
  base64_encode = true
  
  part {
    content_type = "text/cloud-config"
    filename     = "cloud-init.yaml"
    content = templatefile("${path.module}/templates/cloud-init.yaml.tpl", {
      license_content = tg_license.gateway_licenses[each.key].license
    })
  }
  
  part {
    content_type = "text/x-shellscript"
    filename     = "bootstrap.sh"
    content = templatefile("${path.module}/templates/bootstrap.sh.tpl", {
      region          = data.aws_region.current.id
      enroll_endpoint = var.trustgrid_enroll_endpoint
    })
  }
}

