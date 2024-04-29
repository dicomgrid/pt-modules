resource "aws_eip" "main" {
  public_ipv4_pool     = var.byoip_pool == true ? "ipv4pool-ec2-03f7aa330fe7e27cc" : ""
  domain = var.domain
  network_border_group = var.network_border_group

  tags = merge({
    Application = var.Application
    Billing     = var.Billing
    Creator     = var.Creator
    Environment = var.Environment
    Name        = var.Name
    Owner       = var.Owner
    aws-migration-project-id = var.aws_project_id
    map-migrated             = var.map_migrated
  }, var.tags)
}

resource "aws_eip_association" "main" {
  instance_id   = var.instance_id
  allocation_id = aws_eip.main.id
}
