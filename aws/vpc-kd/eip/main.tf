resource "aws_eip" "main" {
  address                   = var.address == "" ? null : var.address
  associate_with_private_ip = var.associate_with_private_ip == "" ? null : var.associate_with_private_ip
  customer_owned_ipv4_pool  = var.customer_owned_ipv4_pool == "" ? null : var.customer_owned_ipv4_pool
  instance                  = var.instance == "" ? null : var.instance
  network_border_group      = var.network_border_group == "" ? null : var.network_border_group
  network_interface         = var.network_interface == "" ? null : var.network_interface
  public_ipv4_pool          = var.public_ipv4_pool == "" ? null : var.public_ipv4_pool
  vpc                       = var.vpc == "" ? true : var.vpc
  tags                      = var.tags

}