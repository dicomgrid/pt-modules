# TrustGrid Gateway Cluster Module

Terraform module for deploying production-ready TrustGrid Gateway clusters into AWS. This module creates a pair of TrustGrid gateway instances that form a highly available active-standby cluster in AWS. 

## 🚨 Important: Active/Passive Routing Behavior

This module implements proper active/passive routing for TrustGrid gateway clusters:

- **Cloud routes are only created on the active node** - The passive node does not create routes initially
- **All routes point to the active node's ENI** - Ensures traffic flows through the active gateway
- **Automatic failover** - TrustGrid automatically updates routes to point to the standby node's ENI during failover
- **Both nodes have access to all route tables** - Required for TrustGrid to manage failover properly
NOTE: Source/Dest Checking MUST be OFF for trustgrid to work properly.

**ROUTING DETAILS**
Routes added to the `edge_route_cidrs` list will:
1. Initially be created pointing to the primary (active) node's data ENI
2. Automatically failover to the secondary node's data ENI when TrustGrid detects a failure
3. Be managed entirely by TrustGrid's cluster logic after initial creation


Trustgrid current AMI's per region   - https://docs.trustgrid.io/tutorials/deployments/deploy-aws-ami/ 

##
#TODO: NEED to integrate with aws secrets manager

To authenticate with trustgrid api - set these environment variables:
```bash
export TG_API_KEY_ID="your-api-key-id"
export TG_API_KEY_SECRET="your-api-key-secret"
```


```
┌─────────────────────────────────────────────────────────────┐
│                        AWS VPC                              │
│                                                             │
│  ┌─────────────────┐              ┌─────────────────┐       │
│  │  Public Subnet  │              │  Public Subnet  │       │
│  │     AZ-A        │              │     AZ-B        │       │
│  │  ┌─────────────┐│              │┌─────────────┐  │       │
│  │  │Gateway-01   ││              ││Gateway-02   │  │       │
│  │  │Management   ││◄─────────────┤│Management   │  │       │
│  │  │NIC + EIP    ││   Cluster    ││NIC + EIP    │  │       │
│  │  └─────────────┘│   Port 9000  │└─────────────┘  │       │
│  └─────────────────┘              └─────────────────┘       │
│           │                                │                │
│  ┌─────────────────┐              ┌─────────────────┐       │
│  │ Private Subnet  │              │ Private Subnet  │       │
│  │     AZ-A        │              │     AZ-B        │       │
│  │  ┌─────────────┐│              │┌─────────────┐  │       │
│  │  │Gateway-01   ││◄─────────────┤│Gateway-02   │  │       │
│  │  │Data NIC     ││  Data Plane  ││Data NIC     │  │       │
│  │  └─────────────┘│   Traffic    │└─────────────┘  │       │
│  └─────────────────┘              └─────────────────┘       │
│                                                             │
│     
│     
└─────────────────────────────────────────────────────────────┘
            │                              │
            ▼                              ▼
    ┌─────────────────────────────────────────────────────────┐
    │              TrustGrid Portal                           │
    │           intelerad.trustgrid.io                        │
    └─────────────────────────────────────────────────────────┘
```

## Private Gateway Security

By default - cross cluster communication can only occur between clusters sharing the same client_code tag.
 this module creates **private gateways** which implement the following security model:

- **No clients can connect without explicit allowance**
- **Tag-based access control** - Allow nodes based on their TrustGrid tags
- **Explicit node allowlisting** - Add specific nodes by FQDN
- **Flexible configuration** - Mix both tag-based and explicit access

### Client Access Control Methods

1. **Tag-Based Access** (`gateway_client_tags`): Dynamically discover and allow nodes with matching tags
2. **Explicit Access** (`additional_gateway_clients`): Allow specific nodes by their FQDN
3. **Combined Access**: Use both methods simultaneously for maximum flexibility





### Example Usage
#### Default Private Gateway (Same Client Code Only)

```hcl
module "trustgrid_gateway" {
  source = "../"
  
  # Required core variables
  client_code        = "acme"
  environment        = "prod" 
  vpc_id            = "vpc-1234567890abcdef0"
  availability_zones = ["us-east-1a", "us-east-1b"]
  
  # By default, only nodes with matching client_code="acme" can connect
  # No additional configuration needed!
  
  #routes managed by trustgrid (add virtual networks here)
  edge_route_cidrs = ["100.65.0.0/12"] ##Virtual network
}
```

#### Private Gateway with Additional Tag Filters

```hcl
module "trustgrid_gateway" {
  source = "../"
  
  # Required core variables
  client_code        = "acme"
  environment        = "prod" 
  vpc_id            = "vpc-1234567890abcdef0"
  availability_zones = ["us-east-1a", "us-east-1b"]
  
  # Allow nodes with client_code="acme" AND environment="prod"
  gateway_client_tags = {
    environment = "prod"
    # client_code is automatically included from the module's client_code variable
  }
  
  edge_route_cidrs = ["100.65.0.0/12"]
}
```

#### Public Gateway (Legacy Mode)

```hcl
module "trustgrid_gateway" {
  source = "../"
  
  # Required core variables
  client_code        = "acme"
  environment        = "prod" 
  vpc_id            = "vpc-1234567890abcdef0"
  availability_zones = ["us-east-1a", "us-east-1b"]
  
  # Explicitly set to public gateway (allows any node to connect)
  trustgrid_gateway_type = "public"
  
  # Network routing configuration
  edge_route_cidrs = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  
  # Optional customization
  instance_type     = "m5.large"
  trustgrid_gateway_port = 8443
}
```

## Architecture

The module deploys the following architecture:

- **2 EC2 Instances**: Deployed across availability zones for high availability
- **Dual Network Interfaces**: Management (public) and data (private) interfaces per instance
- **Active/Passive Clustering**: Automatic failover with route table updates
- **Security Groups**: Separate groups for management and data traffic
- **CloudWatch Integration**: Optional logging for monitoring and troubleshooting

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.0 |
| tg (trustgrid) | >= 0.1.0 |
| cloudinit | >= 2.0 |
| time | >= 0.9 |

### Prerequisites

1. **TrustGrid Account**: Active TrustGrid organization with API credentials
2. **AWS Resources**: 
   - VPC with public and private subnets across 2 AZs
   - EC2 key pair for instance access
   - Appropriate IAM permissions
3. **Environment Variables**:
   ```bash
   export TG_API_KEY_ID="your-api-key-id"
   export TG_API_KEY_SECRET="your-api-key-secret"
   ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client_code | Customer identifier for naming and tagging | `string` | `"ims"` | no |
| environment | Environment name (e.g., dev, staging, prod) | `string` | `"dev"` | no |
| owner | Owner of the resource (email or team name) | `string` | `"infrastructure"` | no |
| product | Product name for naming and tagging | `string` | `"intelepacs"` | no |
| gateway_count | Number of gateways to deploy | `number` | n/a | yes |
| instance_type | EC2 instance type for TrustGrid gateways (t3.large or m5.large) | `string` | n/a | yes |
| key_name | EC2 Key Pair name for instance access | `string` | n/a | yes |
| availability_zones | List of availability zones for multi-AZ deployment (must specify exactly 2) | `list(string)` | `["us-west-1a", "us-west-1c"]` | no |
| ami_id | TrustGrid-provided AMI ID for gateway instances | `string` | `"ami-08e067a9b280ae1dd"` | no |
| vpc_tags | Tags to filter VPCs by for discovery | `map(string)` | `{Name = "tgdev-usw1-1"}` | no |
| private_subnet_tags | Tags to filter private subnets by | `map(string)` | `{SubnetType = "private"}` | no |
| public_subnet_tags | Tags to filter public subnets by | `map(string)` | `{SubnetType = "public"}` | no |
| edge_route_cidrs | List of CIDR blocks for customer edge networks to route through TrustGrid cluster | `list(string)` | `["100.65.0.0/12"]` | no |
| trustgrid_gateway_type | Type of TrustGrid gateway to deploy (public, private, or hub) | `string` | `"private"` | no |
| gateway_client_tags | Tags to identify nodes that should be allowed to connect to these gateways | `map(string)` | `{}` | no |
| additional_gateway_clients | Additional specific node names or FQDNs to allow as gateway clients | `list(string)` | `[]` | no |
| enable_trustgrid_cluster | Enable TrustGrid cluster mode for high availability | `bool` | `true` | no |
| enable_cloudwatch_logs | Enable CloudWatch logs for TrustGrid gateways | `bool` | `true` | no |
| log_retention_days | Number of days to retain CloudWatch logs | `number` | `30` | no |
| gateway_max_throughput_mbps | Maximum gateway ingress throughput in Mbps | `number` | `10000` | no |
| gateway_max_egress_mbps | Maximum gateway egress throughput in Mbps | `number` | `10000` | no |
| ssh_allowed_cidr_blocks | List of CIDR blocks allowed to SSH to the gateways | `list(string)` | `[]` | no |
| gateway_port_allowed_cidr_blocks | List of CIDR blocks allowed to connect to the gateway port (8443) | `list(string)` | `["0.0.0.0/0"]` | no |

### Advanced Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tg_org_id | TrustGrid organization ID | `string` | `"990d1fe2-303b-4f73-b458-c517b8f4b484"` | no |
| trustgrid_gateway_port | Port for remote node access to TrustGrid gateways | `number` | `8443` | no |
| trustgrid_cluster_port | Port for TrustGrid cluster communication | `number` | `9000` | no |
| cluster_health_check_port | Port for cluster health checks | `number` | `8080` | no |
| trustgrid_api_base_url | TrustGrid API base URL for node registration | `string` | `"api.trustgrid.io"` | no |
| trustgrid_enroll_endpoint | TrustGrid enrollment endpoint URL | `string` | `"https://keymaster.trustgrid.io/v2/enroll"` | no |
| node_registration_wait_time | Time to wait for TrustGrid nodes to complete registration | `string` | `"5m"` | no |
| data_interface_name | Network interface name for data traffic | `string` | `"ens6"` | no |
| management_interface_name | Network interface name for management traffic | `string` | `"ens5"` | no |
| enable_udp | Enable UDP traffic for gateway | `bool` | `true` | no |
| connect_to_public | Connect to public gateway | `bool` | `false` | no |
| is_edge_node | Whether this deployment is for edge nodes | `bool` | `false` | no |
| enable_detailed_monitoring | Enable detailed CloudWatch monitoring | `bool` | `true` | no |
| root_volume_size | Size of the root EBS volume in GB | `number` | `20` | no |
| root_volume_type | Type of the root EBS volume | `string` | `"gp3"` | no |
| additional_tags | Additional tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| gateway_instance_ids | List of TrustGrid gateway instance IDs |
| gateway_instance_map | Map of gateway instances by index |
| gateway_public_ips | List of public IPs for TrustGrid gateways |
| gateway_private_ips | List of private IPs for TrustGrid gateway management interfaces |
| gateway_data_private_ips | List of private IPs for TrustGrid gateway data interfaces |
| gateway_names | List of TrustGrid gateway names |
| cluster_name | TrustGrid cluster name |
| cluster_fqdn | TrustGrid cluster FQDN |
| management_network_interface_ids | List of management network interface IDs |
| data_network_interface_ids | List of data network interface IDs |
| management_security_group_id | Security group ID for management interfaces |
| data_security_group_id | Security group ID for data interfaces |
| iam_role_name | IAM role name for TrustGrid gateways |
| iam_instance_profile_name | IAM instance profile name for TrustGrid gateways |
| shared_route_table_id | Shared route table ID for all private subnets (if using single route table) |
| managed_route_table_ids | List of route table IDs managed by TrustGrid |
| vpc_id | VPC ID where gateways are deployed |
| vpc_cidr | VPC CIDR block |
| private_route_table_ids | All private route table IDs discovered |
| gateway_availability_zones | Availability zones where gateways are deployed |
| gateway_node_ids | Map of TrustGrid node IDs by gateway index |
| gateway_subnet_assignments | Subnet assignments for each gateway |
| gateway_network_config | Network configuration for each gateway |
| gateway_data_ips | Data interface IPs for each gateway |
| gateway_lan_cidrs | LAN CIDRs for each gateway |
| infrastructure_context | Complete infrastructure context from foundation module |
| tags | Tags applied to resources |
| active_gateway_public_ip | Public IP of the active gateway |
| gateway_configuration | Complete gateway configuration matrix (sensitive) |

## Security

This module implements several security best practices:

1. **Network Isolation**
   - Management interfaces in public subnets with restricted access
   - Data interfaces in private subnets with no internet access
   - Separate security groups for each interface type

2. **Access Control**
   - SSH access disabled by default (configure `ssh_allowed_cidr_blocks` if needed)
   - Gateway port (8443) access configurable via `gateway_port_allowed_cidr_blocks`
   - Private gateways require explicit client authorization

3. **Encryption**
   - All data in transit encrypted using WireGuard protocol
   - EBS volumes encrypted at rest
   - TLS for control plane communication

4. **IAM Permissions**
   - Least privilege IAM role for instances
   - Permissions limited to required AWS services
   - No hardcoded credentials

## Troubleshooting

### Common Issues

1. **Node Registration Timeout**
   ```
   Error: data.tg_node.registered_gateways["0"]: 404 Not Found
   ```
   **Solution**: Increase `node_registration_wait_time` to allow more time for registration

2. **VPC Discovery Failure**
   ```
   Error: Deployment validation failed: VPC discovery failed
   ```
   **Solution**: Verify `vpc_tags` match your VPC tags exactly

3. **Route Table Access Denied**
   ```
   Error: UnauthorizedOperation: You are not authorized to perform this operation
   ```
   **Solution**: Ensure IAM role has route table management permissions

4. **Client Connection Issues**
   - Verify client node has matching tags (for tag-based access)
   - Check security group rules allow traffic on port 8443
   - Confirm client is listed in `additional_gateway_clients` (for explicit access)

### Debug Mode

Enable detailed logging by setting these environment variables:
```bash
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform-debug.log
```

### Validation

The module includes built-in validation that checks:
- VPC and subnet discovery
- Route table accessibility
- Network configuration consistency
- Deployment prerequisites

## Additional Resources

- [TrustGrid Documentation](https://docs.trustgrid.io)
- [TrustGrid AMI List](https://docs.trustgrid.io/tutorials/deployments/deploy-aws-ami/)
- [Module Technical Guide](./TECHNICAL-GUIDE.md)
- [TrustGrid Architecture Overview](../ARCHITECTURE.md)

