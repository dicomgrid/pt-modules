module "eip" {
  source = "../eip"
  
  address                   = var.address
  associate_with_private_ip = var.associate_with_private_ip
  customer_owned_ipv4_pool  = var.customer_owned_ipv4_pool
  domain                    = var.domain
  instance                  = var.instance
  network_border_group      = var.network_border_group
  network_interface         = var.network_interface
  public_ipv4_pool          = var.public_ipv4_pool
  tags                      = var.tags
}

resource "aws_nat_gateway" "main" {
  allocation_id     = module.eip.id
  connectivity_type = var.connectivity_type
  private_ip        = var.private_ip
  secondary_allocation_ids  = var.secondary_allocation_ids
  secondary_private_ip_address_count = var.secondary_private_ip_address_count
  secondary_private_ip_addresses = var.secondary_private_ip_addresses
  subnet_id         = var.subnet_id
  tags = var.tags
}