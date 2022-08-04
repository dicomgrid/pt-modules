data "aws_customer_gateway" "main" {
  filter {
    name   = "tag:Name"
    values = [var.customer_gateway_name]
  }
}

data "aws_vpn_gateway" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpn_gateway]
  }
}