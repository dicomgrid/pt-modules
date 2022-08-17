resource "aws_vpn_connection" "main" {
  vpn_gateway_id           = data.aws_vpn_gateway.main.id
  customer_gateway_id      = data.aws_customer_gateway.main.id
  type                     = var.vpn_type
  local_ipv4_network_cidr  = var.remote_subnets
  remote_ipv4_network_cidr = var.aws_subnets

  tunnel1_preshared_key = var.preshared_key
  tunnel2_preshared_key = var.preshared_key

  tunnel1_ike_versions = var.ike_version
  tunnel2_ike_versions = var.ike_version

  tunnel1_phase1_dh_group_numbers = var.p1_dh_group_numbers
  tunnel2_phase1_dh_group_numbers = var.p1_dh_group_numbers

  tunnel1_phase1_encryption_algorithms = var.p1_encryption
  tunnel2_phase1_encryption_algorithms = var.p1_encryption

  tunnel1_phase1_integrity_algorithms = var.p1_integrity_algorithms
  tunnel2_phase1_integrity_algorithms = var.p1_integrity_algorithms

  tunnel1_dpd_timeout_seconds = var.dpd_timeout
  tunnel2_dpd_timeout_seconds = var.dpd_timeout

  tunnel1_phase2_dh_group_numbers = var.p2_dh_group_numbers
  tunnel2_phase2_dh_group_numbers = var.p2_dh_group_numbers

  tunnel1_phase2_encryption_algorithms = var.p2_encryption
  tunnel2_phase2_encryption_algorithms = var.p2_encryption

  tunnel1_phase2_integrity_algorithms = var.p2_integrity_algorithms
  tunnel2_phase2_integrity_algorithms = var.p2_integrity_algorithms

  tags = {
    Creator     = var.creator
    Environment = var.environment
    Name        = var.name
    Owner       = var.owner
  }

}
