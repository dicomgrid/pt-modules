locals {
 
  gateway_count          = 2
  gateway_data_ip_offset = 20
  gateway_ip_offset      = 1
  
  # Base naming TODO: Work in progress. a standardized naming module would be nice in the future
  base_name = "${var.client_code}awtggw"
  
  resource_names = {
    gateways       = [for i in range(local.gateway_count) : "${local.base_name}${i + 1}"]
    management_sg  = "${local.base_name}-mgmt-sg"
    data_sg        = "${local.base_name}-data-sg"
    iam_role       = "${local.base_name}-role"
    iam_profile    = "${local.base_name}-role-profile"
  }
  
  gateway_names      = local.resource_names.gateways
  iam_role_name      = local.resource_names.iam_role
  iam_profile_name   = local.resource_names.iam_profile
  management_sg_name = local.resource_names.management_sg
  data_sg_name       = local.resource_names.data_sg
  
  # TrustGrid control plane CIDRs
  trustgrid_control_plane_cidrs = [
    "35.171.100.16/28",
    "34.223.12.192/28"
  ]
  
  # Network discovery
  discovered_subnets = {
    for idx in range(local.gateway_count) : idx => {
      az             = var.availability_zones[idx]
      public_subnet  = try(
        length(lookup(module.foundation.public_subnets_by_az, var.availability_zones[idx], [])) > 0 
          ? module.foundation.public_subnets_by_az[var.availability_zones[idx]][0] 
          : null, 
        null
      )
      private_subnet = try(
        length(lookup(module.foundation.private_subnets_by_az, var.availability_zones[idx], [])) > 0 
          ? module.foundation.private_subnets_by_az[var.availability_zones[idx]][0] 
          : null, 
        null
      )
    }
  }
  
  # Subnet validation
  subnet_validation = {
    all_subnets_found = alltrue([
      for s in local.discovered_subnets : s.public_subnet != null && s.private_subnet != null
    ])
    missing_azs = [
      for idx, s in local.discovered_subnets : var.availability_zones[idx]
      if s.public_subnet == null || s.private_subnet == null
    ]
  }
  
  # Route table analysis
  route_table_analysis = {
    all_tables = [for rt in data.aws_route_table.private : rt.id]
    unique_tables = toset([for rt in data.aws_route_table.private : rt.id])
    is_valid = length(toset([for rt in data.aws_route_table.private : rt.id])) == 1
    shared_table_id = length(toset([for rt in data.aws_route_table.private : rt.id])) == 1 ? tolist(toset([for rt in data.aws_route_table.private : rt.id]))[0] : null
  }
  

  unique_route_table_ids  = local.route_table_analysis.unique_tables
  shared_route_table_id   = local.route_table_analysis.shared_table_id
  managed_route_table_ids = tolist(local.route_table_analysis.unique_tables)
  private_route_table_ids = local.route_table_analysis.all_tables
  route_table_validation  = local.route_table_analysis.is_valid
  
  # Gateway configuration 
  gateway_matrix = {
    for idx in range(local.gateway_count) : idx => {
      name  = local.resource_names.gateways[idx]
      index = idx
      role  = idx == 0 ? "primary" : "secondary"
      
      availability_zone = local.discovered_subnets[idx].az
      public_subnet_id  = local.discovered_subnets[idx].public_subnet
      private_subnet_id = local.discovered_subnets[idx].private_subnet
      
      private_subnet_cidr = data.aws_subnet.private[local.discovered_subnets[idx].private_subnet].cidr_block
      subnet_mask_bits    = tonumber(split("/", data.aws_subnet.private[local.discovered_subnets[idx].private_subnet].cidr_block)[1])
      
      data_ip    = cidrhost(data.aws_subnet.private[local.discovered_subnets[idx].private_subnet].cidr_block, local.gateway_data_ip_offset)
      gateway_ip = cidrhost(data.aws_subnet.private[local.discovered_subnets[idx].private_subnet].cidr_block, local.gateway_ip_offset)
      
      route_table_id = data.aws_route_table.private[local.discovered_subnets[idx].private_subnet].id
      
      peer = {
        index       = (idx + 1) % local.gateway_count
        subnet_cidr = data.aws_subnet.private[local.discovered_subnets[(idx + 1) % local.gateway_count].private_subnet].cidr_block
        data_ip     = cidrhost(data.aws_subnet.private[local.discovered_subnets[(idx + 1) % local.gateway_count].private_subnet].cidr_block, local.gateway_data_ip_offset)
      }
      
      cluster = {
        is_active = idx == 0
        manages_routes = idx == 0
      }
    }
  }
  
  gateway_data_ips = [for g in local.gateway_matrix : g.data_ip]
  gateway_lan_cidrs = [for g in local.gateway_matrix : g.private_subnet_cidr]
  
  gateway_subnet_assignments = [for g in local.gateway_matrix : {
    az             = g.availability_zone
    public_subnet  = g.public_subnet_id
    private_subnet = g.private_subnet_id
  }]
  
  gateway_network_config = [for g in local.gateway_matrix : {
    subnet_cidr    = g.private_subnet_cidr
    data_ip        = g.data_ip
    gateway_ip     = g.gateway_ip
    subnet_mask    = tostring(g.subnet_mask_bits)
    route_table_id = g.route_table_id
    peer_subnet    = g.peer.subnet_cidr
    peer_data_ip   = g.peer.data_ip
    peer_index     = g.peer.index
  }]
  
  node_route_tables = [
    for _ in range(local.gateway_count) : local.managed_route_table_ids
  ]
  
  # Client configuration
  gateway_client_config = {
    tags = merge(
      { client_code = var.client_code },
      var.gateway_client_tags
    )
    groups = {
      allowed_clients = {
        include_tags = merge({ client_code = var.client_code }, var.gateway_client_tags)
        exclude_tags = {}
      }
    }
  }
  
  deployment_ready = alltrue([
    local.subnet_validation.all_subnets_found,
   
    length(var.availability_zones) == local.gateway_count
  ])
  
  validation_errors = concat(
    local.subnet_validation.all_subnets_found ? [] : [
      "Missing subnets in AZs: ${join(", ", local.subnet_validation.missing_azs)}",
      "Expected subnet tags: private_subnet_tags = ${jsonencode(var.private_subnet_tags)}, public_subnet_tags = ${jsonencode(var.public_subnet_tags)}",
      "Found ${length(module.foundation.public_subnet_ids)} public and ${length(module.foundation.private_subnet_ids)} private subnets total in VPC"
    ],
    length(var.availability_zones) == local.gateway_count ? [] : ["Expected ${local.gateway_count} AZs, got ${length(var.availability_zones)}"]
  )
}