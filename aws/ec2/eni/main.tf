resource "aws_network_interface" "main" {
  subnet_id         = var.subnet_id
  private_ips       = var.private_ips
  security_groups   = var.security_groups
  description       = var.description
  source_dest_check = var.source_dest_check
  tags              = local.tags

}

resource "aws_eip" "main" {
  count = var.eip.enabled ? 1 : 0

  network_interface = aws_network_interface.main.id
  domain            = try(var.eip.domain, null)
  tags              = merge(local.tags, try(var.eip.tags, {}))
}
