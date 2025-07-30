# Security group for TrustGrid management interfaces using atomic module
module "management_security_group" {
  source = "git::ssh://git@github.com/intelerad-org/plt-modules.git?ref=aws/security-group/v1.0.0"

  name        = local.management_sg_name
  description = "Security group for TrustGrid gateway management interfaces"
  vpc_name    = var.vpc_tags["Name"]

  ingress = concat(
    var.is_edge_node ? [] : [
      {
        description = "Inbound TCP access for remote nodes to TrustGrid gateway"
        from_port   = var.trustgrid_gateway_port
        to_port     = var.trustgrid_gateway_port
        protocol    = "tcp"
        cidr_blocks = var.gateway_port_allowed_cidr_blocks
        self        = false
      },
      {
        description = "Inbound UDP access for remote nodes to TrustGrid gateway"
        from_port   = var.trustgrid_gateway_port
        to_port     = var.trustgrid_gateway_port
        protocol    = "udp"
        cidr_blocks = var.gateway_port_allowed_cidr_blocks
        self        = false
      }
    ],
    [
      {
        description = "Inbound cluster gossip communication between TrustGrid gateways"
        from_port   = var.trustgrid_cluster_port
        to_port     = var.trustgrid_cluster_port
        protocol    = "tcp"
        self        = true
      },
      {
        description = "Inbound load balancer health check for cluster status"
        from_port   = var.cluster_health_check_port
        to_port     = var.cluster_health_check_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        self        = false
      },
      {
        description = "ICMP for troubleshooting and network diagnostics"
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
        self        = false
      }
    ],
    length(var.ssh_allowed_cidr_blocks) > 0 ? [
      {
        description = "SSH access for troubleshooting"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.ssh_allowed_cidr_blocks
        self        = false
      }
    ] : []
  )

  egress = [
    {
      description = "Outbound access to TrustGrid control plane ${local.trustgrid_control_plane_cidrs[0]}"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [local.trustgrid_control_plane_cidrs[0]]
      self        = false
    },
    {
      description = "Outbound access to TrustGrid control plane ${local.trustgrid_control_plane_cidrs[1]}"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [local.trustgrid_control_plane_cidrs[1]]
      self        = false
    },
    {
      description = "Outbound HTTPS access to TrustGrid control plane ${local.trustgrid_control_plane_cidrs[0]}"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [local.trustgrid_control_plane_cidrs[0]]
      self        = false
    },
    {
      description = "Outbound HTTPS access to TrustGrid control plane ${local.trustgrid_control_plane_cidrs[1]}"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [local.trustgrid_control_plane_cidrs[1]]
      self        = false
    },
    {
      description = "Outbound 8443 access to TrustGrid control plane ${local.trustgrid_control_plane_cidrs[0]}"
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      cidr_blocks = [local.trustgrid_control_plane_cidrs[0]]
      self        = false
    },
    {
      description = "Outbound 8443 access to TrustGrid control plane ${local.trustgrid_control_plane_cidrs[1]}"
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      cidr_blocks = [local.trustgrid_control_plane_cidrs[1]]
      self        = false
    },
    {
      description = "Outbound HTTPS access to AWS API endpoints and TrustGrid initial registration"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = false
    },
    {
      description = "Temporary outbound HTTP for initial registration"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = false
    },
    {
      description = "Outbound cluster gossip communication between TrustGrid gateways"
      from_port   = var.trustgrid_cluster_port
      to_port     = var.trustgrid_cluster_port
      protocol    = "tcp"
      self        = true
    }
  ]

  tags = merge(module.foundation.tags, {
    Type = "management"
  })
}


# Security group for TrustGrid data interfaces using atomic module
module "data_security_group" {
  source = "../../aws/security-group"

  name        = local.data_sg_name
  description = "Security group for TrustGrid gateway data interfaces"  
  vpc_name    = var.vpc_tags["Name"]

  ingress = [
    {
      description = "Inbound data traffic from VPC"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = module.foundation.vpc_cidr_block != null ? [module.foundation.vpc_cidr_block] : ["10.0.0.0/8"]
      self        = false
    },
    {
      description = "Inbound UDP data traffic from VPC"
      from_port   = 0
      to_port     = 65535
      protocol    = "udp"
      cidr_blocks = module.foundation.vpc_cidr_block != null ? [module.foundation.vpc_cidr_block] : ["10.0.0.0/8"]
      self        = false
    },
    {
      description = "Cluster gossip communication between gateway data interfaces"
      from_port   = var.trustgrid_cluster_port
      to_port     = var.trustgrid_cluster_port
      protocol    = "tcp"
      self        = true
    }

  ]

  egress = [
    {
      description = "Allow all outbound data traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self        = false
    }
  ]

  tags = merge(module.foundation.tags, {
    Type = "data"
  })
}