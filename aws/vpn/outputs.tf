output "config" {
  value = { for k, v in var.vpns : k => {
    tunnel1 = {
      phase1 = {
        local_peer_ip   = aws_vpn_connection.main[k].tunnel1_address
        remote_peer_ip  = aws_customer_gateway.main[v.customer_gateway].ip_address
        encryption      = aws_vpn_connection.main[k].tunnel1_phase1_encryption_algorithms
        integrity       = aws_vpn_connection.main[k].tunnel1_phase1_integrity_algorithms
        dg_groups       = aws_vpn_connection.main[k].tunnel1_phase1_dh_group_numbers
        keylife_seconds = aws_vpn_connection.main[k].tunnel1_phase1_lifetime_seconds
      }
      phase2 = {
        encryption      = aws_vpn_connection.main[k].tunnel1_phase2_encryption_algorithms
        integrity       = aws_vpn_connection.main[k].tunnel1_phase2_integrity_algorithms
        dg_groups       = aws_vpn_connection.main[k].tunnel1_phase2_dh_group_numbers
        keylife_seconds = aws_vpn_connection.main[k].tunnel1_phase2_lifetime_seconds
        inside_cidr     = aws_vpn_connection.main[k].tunnel1_inside_cidr
      }
      bgp = {
        local_bgp_peer_ip  = aws_vpn_connection.main[k].tunnel1_vgw_inside_address
        local_bgp_asn      = aws_vpn_connection.main[k].tunnel1_bgp_asn
        remote_bgp_peer_ip = aws_vpn_connection.main[k].tunnel1_cgw_inside_address
        remote_bgp_asn     = aws_customer_gateway.main[v.customer_gateway].bgp_asn
      }
    }
    tunnel2 = {
      phase1 = {
        local_peer_ip   = aws_vpn_connection.main[k].tunnel2_address
        remote_peer_ip  = aws_customer_gateway.main[v.customer_gateway].ip_address
        encryption      = aws_vpn_connection.main[k].tunnel2_phase1_encryption_algorithms
        integrity       = aws_vpn_connection.main[k].tunnel2_phase1_integrity_algorithms
        dg_groups       = aws_vpn_connection.main[k].tunnel2_phase1_dh_group_numbers
        keylife_seconds = aws_vpn_connection.main[k].tunnel2_phase1_lifetime_seconds
      }
      phase2 = {
        encryption      = aws_vpn_connection.main[k].tunnel2_phase2_encryption_algorithms
        integrity       = aws_vpn_connection.main[k].tunnel2_phase2_integrity_algorithms
        dg_groups       = aws_vpn_connection.main[k].tunnel2_phase2_dh_group_numbers
        keylife_seconds = aws_vpn_connection.main[k].tunnel2_phase2_lifetime_seconds
        inside_cidr     = aws_vpn_connection.main[k].tunnel2_inside_cidr

        local_bgp_peer_ip  = aws_vpn_connection.main[k].tunnel2_vgw_inside_address
        local_bgp_asn      = aws_vpn_connection.main[k].tunnel2_bgp_asn
        remote_bgp_peer_ip = aws_vpn_connection.main[k].tunnel2_cgw_inside_address
        remote_bgp_asn     = aws_customer_gateway.main[v.customer_gateway].bgp_asn
      }
    }
  } }
}
