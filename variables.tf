
variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner of the resource (email or team name)"
  type        = string
  default     = "infrastructure"
}


variable "product" {
  description = "Product name for naming and tagging"
  type        = string
  default     = "intelepacs"
}


variable "client_code" {
  description = "Customer identifier for naming and tagging"
  type        = string
  default     = "ims"

}


variable "private_subnet_tags" {
  description = "Tags to filter private subnets by"
  type        = map(string)
  default = {
    SubnetType = "private"
  }
}

variable "public_subnet_tags" {
  description = "Tags to filter public subnets by"
  type        = map(string)
  default = {
    SubnetType = "public"
  }
}
variable "vpc_tags" {
  description = "Tags to filter VPCs by for discovery"
  type        = map(string)
  default = {
    Name = "tgdev-usw1-1"
  }
}



variable "tg_org_id" {
  description = "TrustGrid organization ID"
  type        = string
  default     = "990d1fe2-303b-4f73-b458-c517b8f4b484"
}

variable "trustgrid_gateway_port" {
  description = "Port for remote node access to TrustGrid gateways"
  type        = number
  default     = 8443

}

variable "trustgrid_cluster_port" {
  description = "Port for TrustGrid cluster communication"
  type        = number
  default     = 9000

}

variable "availability_zones" {
  description = "List of availability zones for multi-AZ deployment (must specify exactly 2)"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
}

variable "ami_id" {
  description = "TrustGrid-provided AMI ID for gateway instances"
  type        = string
  default     = "ami-08e067a9b280ae1dd"
}

variable "key_name" {
  description = "EC2 Key Pair name for instance access"
  type        = string
}


variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring for gateway instances"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 20

}

variable "root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp3"
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}


variable "enable_trustgrid_cluster" {
  description = "Enable TrustGrid cluster mode for high availability"
  type        = bool
  default     = true
}

variable "trustgrid_api_base_url" {
  description = "TrustGrid API base URL for node registration"
  type        = string
  default     = "api.trustgrid.io"
}

variable "trustgrid_enroll_endpoint" {
  description = "TrustGrid enrollment endpoint URL"
  type        = string
  default     = "https://keymaster.trustgrid.io/v2/enroll"
}



variable "edge_route_cidrs" {
  description = "List of CIDR blocks for customer edge networks to route through TrustGrid cluster"
  type        = list(string)
  default     = ["100.65.0.0/12"]
}

variable "node_registration_wait_time" {
  description = "Time to wait for TrustGrid nodes to complete registration after EC2 instance launch. Increase this if you see 404 errors."
  type        = string
  default     = "5m"

}

variable "data_interface_name" {
  description = "Network interface name for data traffic (AWS: ens6, other: eth1)"
  type        = string
  default     = "ens6"

}

variable "management_interface_name" {
  description = "Network interface name for management traffic (AWS: ens5, other: eth0)"
  type        = string
  default     = "ens5"

}


variable "gateway_max_throughput_mbps" {
  description = "Maximum gateway ingress throughput in Mbps"
  type        = number
  default     = 10000

  validation {
    condition     = var.gateway_max_throughput_mbps > 0 && var.gateway_max_throughput_mbps <= 10000
    error_message = "Gateway max throughput must be between 1 and 10000 Mbps."
  }
}
variable "instance_type" {
  description = "EC2 instance type for TrustGrid gateways (t3.large or m5.large)"
  type        = string

}
variable "gateway_max_egress_mbps" {
  description = "Maximum gateway egress throughput in Mbps"
  type        = number
  default     = 10000

}

variable "trustgrid_gateway_type" {
  description = "Type of TrustGrid gateway to deploy (public, private, or hub)"
  type        = string
  default     = "private"
}



variable "enable_udp" {
  description = "Enable UDP traffic for gateway"
  type        = bool
  default     = true
}


variable "connect_to_public" {
  description = "Connect to public gateway"
  type        = bool
  default     = false
}

variable "additional_gateway_clients" {    ###Hardcode clients if thats desired
  description = "Additional specific node names or FQDNs to allow as gateway clients"
  type        = list(string)
  default     = []
}
variable "gateway_client_tags" {
  description = "Tags to identify nodes that should be allowed to connect to these gateways(These will be AND'd with client_code)"
  type        = map(string)
  default     = {}

}
variable "gateway_count" {
  description = "Number of gateways to deploy"
  type        = number
}
variable "ssh_allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH to the gateways. Default is empty for security."
  type        = list(string)
  default     = []
  
  validation {
    condition     = length(var.ssh_allowed_cidr_blocks) == 0 || alltrue([for cidr in var.ssh_allowed_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "All values must be valid CIDR blocks."
  }
}

variable "gateway_port_allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to connect to the gateway port (8443). Default allows all (0.0.0.0/0)."
  type        = list(string)
  default     = ["0.0.0.0/0"]
  
  validation {
    condition     = alltrue([for cidr in var.gateway_port_allowed_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "All values must be valid CIDR blocks."
  }
}

variable "is_edge_node" {
  description = "Whether this deployment is for edge nodes (true) or gateway nodes (false). Edge nodes don't need inbound access on port 8443."
  type        = bool
  default     = false
}

variable "cluster_health_check_port" {
  description = "Port for cluster health checks"
  type        = number
  default     = 8080
}
variable "enable_cloudwatch_logs" {
  description = "Enable CloudWatch logs for TrustGrid gateways"
  type        = bool
  default     = true
}
variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}